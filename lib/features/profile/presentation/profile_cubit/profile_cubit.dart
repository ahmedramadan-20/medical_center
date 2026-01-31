import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/features/auth/data/models/user_model.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_state.dart';
import 'package:medical_center/generated/l10n.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final _logger = LoggerService('ProfileCubit');
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

  /// Update user profile information.
  ///
  /// Updates firstName, lastName, phone, and optionally profile photo.
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
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Add photo if provided (field name is 'image' not 'profilePhoto')
      if (profilePhotoBase64 != null && profilePhotoBase64.isNotEmpty) {
        updateData['image'] = profilePhotoBase64;
      }

      // Update in Firestore using the stored document ID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userDocId)
          .update(updateData);

      // Update local user data
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
