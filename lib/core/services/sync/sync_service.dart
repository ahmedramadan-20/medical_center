import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medical_center/core/database/cache/cache_helper.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/sync/sync_action_model.dart';
import 'package:uuid/uuid.dart';

class SyncService {
  SyncService({
    required this.cacheHelper,
    required this.connectionChecker,
  }) {
    _init();
  }

  final CacheHelper cacheHelper;
  final InternetConnectionChecker connectionChecker;
  final _logger = LoggerService('SyncService');
  static const String _queueKey = 'offline_sync_queue';

  final StreamController<bool> _syncStatusController =
      StreamController<bool>.broadcast();
  Stream<bool> get syncStatusStream => _syncStatusController.stream;

  void _init() {
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        processQueue();
      }
    });
  }

  Future<void> addToQueue({
    required String type,
    required Map<String, dynamic> payload,
  }) async {
    final action = SyncActionModel(
      id: const Uuid().v4(),
      type: type,
      payload: payload,
      createdAt: DateTime.now(),
    );

    final queue = await _getQueue();
    queue.add(action);
    await _saveQueue(queue);
    _logger.info('Added action to sync queue: ${action.type}');
  }

  Future<void> processQueue() async {
    if (!await connectionChecker.hasConnection) return;

    final queue = await _getQueue();
    if (queue.isEmpty) return;

    _logger.info('Processing sync queue: ${queue.length} items');
    _syncStatusController.add(true); // Syncing started

    final remainingQueue = <SyncActionModel>[];

    for (final action in queue) {
      try {
        await _processAction(action);
        _logger.info('Action processed: ${action.type}');
      } catch (e) {
        _logger.error('Failed to process action: ${action.type}', e);
        // Keep in queue if it's a temporary error, or move to DLQ?
        // For now, keep in queue only if it's not a fatal bad request
        remainingQueue.add(action);
      }
    }

    await _saveQueue(remainingQueue);
    _syncStatusController.add(false); // Syncing finished
  }

  Future<void> _processAction(SyncActionModel action) async {
    switch (action.type) {
      case SyncActionModel.updateProfile:
        await _processUpdateProfile(action.payload);
        break;
      case SyncActionModel.addFavorite:
        await _processAddFavorite(action.payload);
        break;
      case SyncActionModel.removeFavorite:
        await _processRemoveFavorite(action.payload);
        break;
      case SyncActionModel.bookAppointment:
        await _processBookAppointment(action.payload);
        break;
      case SyncActionModel.cancelAppointment:
        await _processCancelAppointment(action.payload);
        break;
      case SyncActionModel.addReview:
        await _processAddReview(action.payload);
        break;
      default:
        _logger.warning('Unknown sync action type: ${action.type}');
    }
  }

  Future<void> _processUpdateProfile(Map<String, dynamic> payload) async {
    final userId = payload['userId'];
    final data = payload['data'] as Map<String, dynamic>;

    if (userId == null) throw Exception('UserId missing in profile update');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(data);
  }

  Future<void> _processAddFavorite(Map<String, dynamic> payload) async {
    await FirebaseFirestore.instance.collection('favorites').add(payload);
  }

  Future<void> _processRemoveFavorite(Map<String, dynamic> payload) async {
    final userId = payload['userId'];
    final doctorId = payload['doctorId'];

    final snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .where('doctorId', isEqualTo: doctorId)
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> _processBookAppointment(Map<String, dynamic> payload) async {
    await FirebaseFirestore.instance.collection('appointments').add(payload);
  }

  Future<void> _processCancelAppointment(Map<String, dynamic> payload) async {
    final appointmentId = payload['appointmentId'];
    if (appointmentId == null) return;

    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointmentId)
        .update({'status': 'cancelled'});
  }

  Future<void> _processAddReview(Map<String, dynamic> payload) async {
    // 1. Add review
    final reviewRef = FirebaseFirestore.instance.collection('reviews').doc();
    final reviewData = Map<String, dynamic>.from(payload);
    reviewData['id'] = reviewRef.id;
    await reviewRef.set(reviewData);

    // 2. Update appointment isReviewed
    final appointmentId = payload['appointmentId'];
    if (appointmentId != null) {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({'isReviewed': true});
    }

    // 3. Update Doctor Rating (Simplified logic for background sync)
    // Note: To perfectly match ReviewCubit logic, we'd need to fetch doctor, calc avg, etc.
    // Ideally, this logic belongs in a Cloud Function or shared repository.
    // For now, implementing the aggregation logic here.
    final doctorId = payload['doctorId'];
    final rating = payload['rating'] as num;
    if (doctorId != null) {
      await _updateDoctorRating(doctorId, rating.toDouble());
    }
  }

  Future<void> _updateDoctorRating(String doctorId, double newRating) async {
    final doctorRef =
        FirebaseFirestore.instance.collection('doctors').doc(doctorId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(doctorRef);
      if (!snapshot.exists) return;

      final double currentAvg =
          (snapshot.data()?['averageRating'] ?? 0.0).toDouble();
      final int currentCount = snapshot.data()?['numberOfReviews'] ?? 0;

      final newCount = currentCount + 1;
      final newAvg = ((currentAvg * currentCount) + newRating) / newCount;

      transaction.update(doctorRef, {
        'averageRating': newAvg,
        'numberOfReviews': newCount,
      });
    });
  }

  Future<List<SyncActionModel>> _getQueue() async {
    final jsonString = cacheHelper.getDataString(key: _queueKey);
    if (jsonString == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => SyncActionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.error('Error parsing sync queue', e);
      return [];
    }
  }

  Future<void> _saveQueue(List<SyncActionModel> queue) async {
    final jsonList = queue.map((e) => e.toJson()).toList();
    await cacheHelper.saveData(key: _queueKey, value: jsonEncode(jsonList));
  }
}
