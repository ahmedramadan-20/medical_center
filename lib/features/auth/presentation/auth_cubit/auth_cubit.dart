import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/logger_service.dart';
import 'package:medical_center/core/services/notification_service.dart';
import 'package:medical_center/core/utils/app_constants.dart';
import 'package:medical_center/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:medical_center/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:medical_center/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:medical_center/features/auth/presentation/auth_cubit/auth_state.dart';

enum Gender { male, female }

/// Cubit for managing authentication state and user input.
///
/// This cubit handles user authentication flows including sign up, sign in,
/// and password reset. It follows clean architecture by using use cases
/// and repositories for business logic.
///
/// **Features:**
/// - Email/password sign up with profile creation
/// - Email/password sign in
/// - Password reset via email
/// - Form state management (validation, visibility)
/// - Gender and blood type selection
///
/// **Usage:**
/// ```dart
/// final cubit = context.read<AuthCubit>();
/// cubit.firstName = 'John';
/// cubit.lastName = 'Doe';
/// await cubit.signUpWithEmailAndPassword();
/// ```
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _signUpUseCase = signUpUseCase,
        _signInUseCase = signInUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(AuthInitial());

  final _logger = LoggerService('AuthCubit');
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

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

  /// Signs up a new user with email and password.
  ///
  /// Creates a Firebase Auth account and stores user profile in Firestore.
  /// Also creates a blood type record for the blood bank feature.
  ///
  /// **Required fields:** [firstName], [lastName], [emailAddress],
  /// [password], [phoneNumber], [gender]
  ///
  /// **Optional:** [bloodType] (defaults to 'Unknown')
  ///
  /// Emits [SignUpLoadingState] during processing, then either
  /// [SignUpSuccessState] or [SignUpErrorState].
  Future<void> signUpWithEmailAndPassword() async {
    emit(SignUpLoadingState());
    _logger.info('Sign up attempt for: $emailAddress');

    final result = await _signUpUseCase(
      SignUpParams(
        firstName: firstName!,
        lastName: lastName!,
        email: emailAddress!,
        password: password!,
        phone: phoneNumber!,
        gender: gender!,
        bloodType: bloodType ?? 'Unknown',
        image: userImage,
      ),
    );

    result.fold(
      (failure) {
        _logger.warning('Sign up failed for $emailAddress: ${failure.message}');
        emit(SignUpErrorState(errMessage: failure.message));
      },
      (_) async {
        _logger.info('Sign up successful for $emailAddress');
        // Update FCM token on successful sign up
        await NotificationService().updateUserToken(emailAddress!);
        emit(SignUpSuccessState());
      },
    );
  }

  /// Updates the terms and conditions checkbox value.
  void updateTermsAndConditionsCheckBox({required bool newValue}) {
    termsAndConditionsCheckBoxValue = newValue;
    emit(TermsAndConditionsUpdateState());
  }

  /// Toggles password visibility.
  void obscurePasswordText() {
    obscurePasswordTextValue = !obscurePasswordTextValue!;
    emit(ObscurePasswordTextUpdateState());
  }

  /// Signs in an existing user with email and password.
  ///
  /// Authenticates with Firebase Auth using provided credentials.
  ///
  /// **Required fields:** [emailAddress], [password]
  ///
  /// Emits [SignInLoadingState] during processing, then either
  /// [SignInSuccessState] or [SignInErrorState].
  Future<void> signInWithEmailAndPassword() async {
    emit(SignInLoadingState());
    _logger.info('Sign in attempt for: $emailAddress');

    final result = await _signInUseCase(
      SignInParams(
        email: emailAddress!,
        password: password!,
      ),
    );

    result.fold(
      (failure) {
        _logger.warning('Sign in failed for $emailAddress: ${failure.message}');
        emit(SignInErrorState(errMessage: failure.message));
      },
      (_) async {
        _logger.info('Sign in successful for $emailAddress');
        // Update FCM token on successful sign in
        await NotificationService().updateUserToken(emailAddress!);
        emit(SignInSuccessState());
      },
    );
  }

  /// Sends a password reset email to the user.
  ///
  /// Sends a Firebase password reset email to the specified address.
  /// User will receive an email with a link to reset their password.
  ///
  /// **Required fields:** [emailAddress]
  ///
  /// Emits [ResetPasswordLoadingState] during processing, then either
  /// [ResetPasswordSuccessState] or [ResetPasswordErrorState].
  Future<void> restPasswordWithLink() async {
    emit(ResetPasswordLoadingState());
    _logger.info('Password reset requested for: $emailAddress');

    final result = await _resetPasswordUseCase(
      ResetPasswordParams(email: emailAddress!),
    );

    result.fold(
      (failure) {
        _logger.warning(
          'Password reset failed for $emailAddress: ${failure.message}',
        );
        emit(ResetPasswordErrorState(errMessage: failure.message));
      },
      (_) {
        _logger.info('Password reset email sent to $emailAddress');
        emit(ResetPasswordSuccessState());
      },
    );
  }

  List<String> bloodTypes = [
    'blood_type_A_positive',
    'blood_type_A_negative',
    'blood_type_B_positive',
    'blood_type_B_negative',
    'blood_type_AB_positive',
    'blood_type_AB_negative',
    'blood_type_O_positive',
    'blood_type_O_negative',
    'blood_type_unknown',
  ];

  /// Selects a gender for the user during registration.
  void selectGender({required String value}) {
    gender = value;
    emit(SelectGenderState());
  }

  /// Selects a blood type for the user during registration.
  void selectBloodType({required String value}) {
    bloodType = value;
    emit(SelectBloodTypeState());
  }
}
