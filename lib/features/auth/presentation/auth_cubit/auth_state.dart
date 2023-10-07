
abstract class AuthState {}

final class AuthInitial extends AuthState {}

// sign Up
final class SignUpLoadingState extends AuthState {}
final class SignUpSuccessState extends AuthState {}
final class SignUpErrorState extends AuthState {
  final String errMessage;

  SignUpErrorState({required this.errMessage});
}
final class TermsAndConditionsUpdateState extends AuthState {}
final class ObscurePasswordTextUpdateState extends AuthState {}


// sign In
final class SignInLoadingState extends AuthState {}
final class SignInSuccessState extends AuthState {}
final class SignInErrorState extends AuthState {
  final String errMessage;

  SignInErrorState({required this.errMessage});
}



// send reset password link
final class ResetPasswordLoadingState extends AuthState {}
final class ResetPasswordSuccessState extends AuthState {}
final class ResetPasswordErrorState extends AuthState {
  final String errMessage;

  ResetPasswordErrorState({required this.errMessage});
}