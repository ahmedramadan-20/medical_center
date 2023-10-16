import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  bool? termsAndConditionsCheckBoxValue = false;
  bool? obscurePasswordTextValue = true;
  GlobalKey<FormState> signupFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();

  Future<void> signUpWithEmailAndPassword() async {
    try {
      emit(SignUpLoadingState());
      // final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      );
      await addUserProfile();
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
      emit(SignUpErrorState(errMessage: 'The password provided is too weak.'));
    } else if (e.code == 'email-already-in-use') {
      emit(SignUpErrorState(
          errMessage: 'The account already exists for that email.'));
    } else if (e.code == 'invalid-email') {
      emit(SignUpErrorState(errMessage: 'The email is invalid.'));
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
        emit(SignInErrorState(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SignInErrorState(
            errMessage: 'Wrong password provided for that user.'));
      } else {
        emit(SignInErrorState(errMessage: 'Check your Email and Password'));
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
      'email': emailAddress,
      'first_name': firstName,
      'last_name': lastName,
      'isAdmin': false,
    });
  }
}
