import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/// Cubit for managing user's favorite doctors.
import 'package:medical_center/core/network/network_info.dart';
import 'package:medical_center/core/services/sync/sync_action_model.dart';
import 'package:medical_center/core/services/sync/sync_service.dart';
import 'package:medical_center/features/favorites/data/models/favorite_model.dart';
import 'package:medical_center/features/favorites/presentation/manager/favorites_state.dart';
import 'package:medical_center/features/home/data/models/doctors_model.dart';

/// Cubit for managing user's favorite doctors.
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required NetworkInfo networkInfo,
    required SyncService syncService,
  })  : _networkInfo = networkInfo,
        _syncService = syncService,
        super(FavoritesInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NetworkInfo _networkInfo;
  final SyncService _syncService;

  List<String> _favoriteDoctorIds = [];
  List<DoctorsModel> _favoriteDoctors = [];

  List<String> get favoriteDoctorIds => _favoriteDoctorIds;
  List<DoctorsModel> get favoriteDoctors => _favoriteDoctors;

  /// Load user's favorite doctors
  Future<void> loadFavorites() async {
    try {
      emit(FavoritesLoading());

      final userId = _auth.currentUser?.email;
      if (userId == null) {
        emit(const FavoritesError('User not logged in'));
        return;
      }

      // Get favorite IDs
      final favoritesSnapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .get();

      _favoriteDoctorIds = favoritesSnapshot.docs
          .map((doc) => doc.data()['doctorId'] as String)
          .toList();

      // Get doctor details for favorites using efficient whereIn query
      if (_favoriteDoctorIds.isNotEmpty) {
        // Firestore whereIn supports max 30 items per query
        _favoriteDoctors = [];
        final chunks = _chunkList(_favoriteDoctorIds, 30);
        for (final chunk in chunks) {
          final snapshot = await _firestore
              .collection('doctors')
              .where(FieldPath.documentId, whereIn: chunk)
              .get();
          _favoriteDoctors
              .addAll(snapshot.docs.map(DoctorsModel.fromFirestore));
        }
      } else {
        _favoriteDoctors = [];
      }

      emit(FavoritesLoaded(_favoriteDoctors));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  /// Add a doctor to favorites with offline support
  Future<void> addFavorite(String doctorId) async {
    final userId = _auth.currentUser?.email;
    if (userId == null) return;

    // 1. Optimistic Update
    if (!_favoriteDoctorIds.contains(doctorId)) {
      _favoriteDoctorIds.add(doctorId);
      emit(FavoriteAdded(doctorId));
    }

    // 2. Offline Check
    if (!await _networkInfo.isConnected) {
      final favorite = FavoriteModel(
        userId: userId,
        doctorId: doctorId,
        addedAt: DateTime.now(),
      );

      await _syncService.addToQueue(
        type: SyncActionModel.addFavorite,
        payload: favorite.toJson(),
      );
      return;
    }

    try {
      final favorite = FavoriteModel(
        userId: userId,
        doctorId: doctorId,
        addedAt: DateTime.now(),
      );

      await _firestore.collection('favorites').add(favorite.toJson());
      await loadFavorites();
      emit(FavoriteAdded(doctorId));
    } catch (e) {
      // Revert on error
      _favoriteDoctorIds.remove(doctorId);
      emit(FavoritesError(e.toString()));
    }
  }

  /// Remove a doctor from favorites with offline support
  Future<void> removeFavorite(String doctorId) async {
    final userId = _auth.currentUser?.email;
    if (userId == null) return;

    // 1. Optimistic Update
    if (_favoriteDoctorIds.contains(doctorId)) {
      _favoriteDoctorIds.remove(doctorId);
      _favoriteDoctors.removeWhere((doc) => doc.id == doctorId);
      emit(FavoriteRemoved(doctorId));
    }

    // 2. Offline Check
    if (!await _networkInfo.isConnected) {
      await _syncService.addToQueue(
        type: SyncActionModel.removeFavorite,
        payload: {
          'userId': userId,
          'doctorId': doctorId,
        },
      );
      return;
    }

    try {
      final snapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .where('doctorId', isEqualTo: doctorId)
          .get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }

      await loadFavorites();
      emit(FavoriteRemoved(doctorId));
    } catch (e) {
      // Revert on error (complex to revert fully without re-fetching,
      // but we can re-add ID at least)
      _favoriteDoctorIds.add(doctorId);
      emit(FavoritesError(e.toString()));
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String doctorId) async {
    if (_favoriteDoctorIds.contains(doctorId)) {
      await removeFavorite(doctorId);
    } else {
      await addFavorite(doctorId);
    }
  }

  /// Check if doctor is favorited
  bool isFavorite(String doctorId) => _favoriteDoctorIds.contains(doctorId);

  /// Splits a list into chunks of specified size.
  /// Used for Firestore whereIn queries which have a limit of 30 items.
  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    final chunks = <List<T>>[];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, (i + chunkSize).clamp(0, list.length)));
    }
    return chunks;
  }
}
