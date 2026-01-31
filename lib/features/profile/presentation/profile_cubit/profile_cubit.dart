import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/network/network_info.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/sync/sync_action_model.dart';
import 'package:medical_center/core/services/sync/sync_service.dart';
import 'package:medical_center/features/auth/data/models/user_model.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_state.dart';
import 'package:medical_center/generated/l10n.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required NetworkInfo networkInfo,
    required SyncService syncService,
  })  : _networkInfo = networkInfo,
        _syncService = syncService,
        super(ProfileInitial());

  final _logger = LoggerService('ProfileCubit');
  final NetworkInfo _networkInfo;
  final SyncService _syncService;
  UserModel? originalUser;
  String? _userDocId; // Store the document ID

  Future<void> getUserData() async {
    emit(GetProfileUserDataLoadingState());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _userDocId = snapshot.docs.first.id;
        originalUser = UserModel.fromJson(snapshot.docs.first.data());
        _logger.info('User data loaded: ${originalUser?.email}');
        _logger.debug('User Document ID: $_userDocId');
        emit(GetProfileUserDataSuccessState());
      } else {
        emit(GetProfileUserDataErrorState(error: S.current.no_user_found));
      }
    } catch (error) {
      emit(GetProfileUserDataErrorState(error: error.toString()));
    }
  }

  /// Update user profile information with offline support.
  Future<void> updateProfile({
    required String name,
    required String phone,
    String? profilePhotoBase64,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(ProfileUpdateError('User not logged in'));
        return;
      }

      if (_userDocId == null) {
        emit(ProfileUpdateError('User document not found'));
        return;
      }

      // Split name into first and last name
      final nameParts = name.trim().split(' ');
      final firstName = nameParts.first;
      final lastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final updateData = <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'updatedAt': FieldValue.serverTimestamp()
            .toString(), // Convert to string for serialization
      };

      if (profilePhotoBase64 != null && profilePhotoBase64.isNotEmpty) {
        updateData['image'] = profilePhotoBase64;
      }

      // 1. Optimistic Update (Local State)
      // Update originalUser immediately so UI reflects changes
      if (originalUser != null) {
        final updatedUserAsMap = originalUser!.toMap();
        updatedUserAsMap['firstName'] = firstName;
        updatedUserAsMap['lastName'] = lastName;
        updatedUserAsMap['phone'] = phone;
        if (profilePhotoBase64 != null && profilePhotoBase64.isNotEmpty) {
          updatedUserAsMap['image'] = profilePhotoBase64;
        }
        originalUser = UserModel.fromJson(updatedUserAsMap);
      }

      // 2. Check Connectivity
      if (!await _networkInfo.isConnected) {
        _logger.info('Offline: Queueing profile update');

        await _syncService.addToQueue(
          type: SyncActionModel.updateProfile,
          payload: {
            'userId': _userDocId,
            'data': updateData,
          },
        );

        emit(ProfileUpdateSuccess('Saved locally. Will sync when online.'));
        return;
      }

      // 3. Online Update
      // Use FieldValue.serverTimestamp() for actual Firestore update
      // We need a clean map for Firestore, re-creating it to use proper FieldValue
      final firestoreData = Map<String, dynamic>.from(updateData);
      firestoreData['updatedAt'] = FieldValue.serverTimestamp();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userDocId)
          .update(firestoreData);

      // Refresh local data to be sure (optional if optimistic update is trusted)
      await getUserData();

      emit(ProfileUpdateSuccess('Profile updated successfully'));
    } catch (e, stackTrace) {
      _logger.error('Error updating profile', e, stackTrace);
      emit(ProfileUpdateError(e.toString()));
    }
  }

  /// Update only the profile photo.
  Future<void> updateProfilePhoto(String photoBase64) async {
    emit(ProfileUpdateLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(ProfileUpdateError('User not logged in'));
        return;
      }

      if (_userDocId == null) {
        emit(ProfileUpdateError('User document not found'));
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userDocId)
          .update({
        'image': photoBase64, // Use 'image' field instead of 'profilePhoto'
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update local user data
      await getUserData();

      emit(ProfileUpdateSuccess('Profile photo updated successfully'));
    } catch (e, stackTrace) {
      _logger.error('Error updating profile photo', e, stackTrace);
      emit(ProfileUpdateError(e.toString()));
    }
  }
}
