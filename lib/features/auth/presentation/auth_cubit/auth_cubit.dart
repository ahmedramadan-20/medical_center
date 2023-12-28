import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/utils/app_constants.dart';
import '../../../../generated/l10n.dart';
import 'auth_state.dart';

enum Gender { male, female }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? firstName;
  String? lastName;
  String? emailAddress;
  String? phoneNumber;
  String? password;
  bool? termsAndConditionsCheckBoxValue = false;
  bool? obscurePasswordTextValue = true;
  GlobalKey<FormState> signupFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();
  String? gender;
  String? bloodType;

  Future<void> signUpWithEmailAndPassword() async {
    try {
      emit(SignUpLoadingState());
      // final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      await addUserProfile();
      await createBloodType();
      await verifyEmail();
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      _signUpHandelException(e);
    } catch (e) {
      emit(SignUpErrorState(errMessage: e.toString()));
    }
  }

  void _signUpHandelException(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      emit(SignUpErrorState(errMessage: S.current.weak_password));
    } else if (e.code == 'email-already-in-use') {
      emit(SignUpErrorState(errMessage: S.current.account_already_exists));
    } else if (e.code == 'invalid-email') {
      emit(SignUpErrorState(errMessage: S.current.invalid_email));
    } else {
      emit(SignUpErrorState(errMessage: e.code));
    }
  }

  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  void updateTermsAndConditionsCheckBox({required newValue}) {
    termsAndConditionsCheckBoxValue = newValue;
    emit(TermsAndConditionsUpdateState());
  }

  void obscurePasswordText() {
    if (obscurePasswordTextValue == true) {
      obscurePasswordTextValue = false;
    } else {
      obscurePasswordTextValue = true;
    }
    emit(ObscurePasswordTextUpdateState());
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress!, password: password!);
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInErrorState(errMessage: S.current.no_user_found));
      } else if (e.code == 'wrong-password') {
        emit(SignInErrorState(errMessage: S.current.wrong_password));
      } else {
        emit(SignInErrorState(
            errMessage: S.current.check_your_email_and_password));
      }
    } catch (e) {
      emit(SignInErrorState(errMessage: e.toString()));
    }
  }

  Future<void> restPasswordWithLink() async {
    try {
      emit(ResetPasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress!);
      emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordErrorState(errMessage: e.toString()));
    }
  }

  Future<void> addUserProfile() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'firstName': firstName!,
      'lastName': lastName!,
      'email': emailAddress!,
      'image': userImage,
      'phone': phoneNumber!,
      'gender': gender!,
      'bloodType': bloodType ?? 'Unknown',
      'isAdmin': false,
    });
  }

  List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
    'Unknown'
  ];

  // select gender
  void selectGender({required value}) {
    gender = value;
    if (kDebugMode) {
      print(gender);
    }
    emit(SelectGenderState());
  }

  //select blood type
  void selectBloodType({required value}) {
    bloodType = value;
    if (kDebugMode) {
      print(bloodType);
    }
    emit(SelectBloodTypeState());
  }

  // crate blood type
  Future<void> createBloodType() async {
    try {
      emit(CreateBloodTypeLoadingState());
      await FirebaseFirestore.instance  .collection('bloodTypes')
      .add({
        'firstName': firstName,
        'lastName': lastName,
        'bloodType': bloodType,
        'phone': phoneNumber,
        'gender': gender,
        'email': emailAddress,

      });
      emit(CreateBloodTypeSuccessState());
    }
    catch (e) {
      emit(CreateBloodTypeErrorState(errMessage: e.toString()));
    }
  }
}
