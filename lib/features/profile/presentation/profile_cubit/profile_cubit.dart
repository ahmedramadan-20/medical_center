
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_state.dart';

import '../../../home/data/models/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserModel? originalUser;

  Future<void> getUserData() async {
    emit(GetProfileUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        originalUser = UserModel.fromJson(value.docs.first.data());
        if (kDebugMode) {
          print("*****************************${originalUser?.email}");
        }
        emit(GetProfileUserDataSuccessState());
      } else {
        // Handle the case where no user with the specified email is found
        emit(GetProfileUserDataErrorState(error: "User not found"));
      }
    }).catchError((error) {
      emit(GetProfileUserDataErrorState(error: error.toString()));
    });
  }

}
