import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/home/data/models/blood_type_model.dart';

abstract class AdminBloodState {}

class AdminBloodInitial extends AdminBloodState {}

class AdminBloodLoading extends AdminBloodState {}

class AdminBloodLoaded extends AdminBloodState {
  AdminBloodLoaded(this.records);
  final List<BloodTypeModel> records;
}

class AdminBloodError extends AdminBloodState {
  AdminBloodError(this.message);
  final String message;
}

/// Manages admin operations for blood donation records.
///
/// This cubit handles:
/// - Loading all blood type records with real-time updates
/// - Monitoring blood bank inventory
///
/// Uses Firestore snapshots for live data synchronization.
class AdminBloodCubit extends Cubit<AdminBloodState> {
  AdminBloodCubit() : super(AdminBloodInitial());

  final _logger = LoggerService('AdminBloodCubit');
  StreamSubscription<QuerySnapshot>? _bloodSubscription;

  /// Loads all blood records with real-time updates.
  Future<void> getBloodRecords() async {
    emit(AdminBloodLoading());
    _logger.info('Loading blood donation records');
    try {
      await _bloodSubscription?.cancel();
      _bloodSubscription = FirebaseFirestore.instance
          .collection('bloodTypes')
          .snapshots()
          .listen((snapshot) {
        final records = snapshot.docs
            .map((doc) => BloodTypeModel.fromJson(doc.data()))
            .toList();
        _logger.info('Loaded ${records.length} blood records');
        emit(AdminBloodLoaded(records));
      });
    } catch (e) {
      _logger.error('Error loading blood records', e);
      emit(AdminBloodError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _logger.info('Closing AdminBloodCubit');
    _bloodSubscription?.cancel();
    return super.close();
  }
}
