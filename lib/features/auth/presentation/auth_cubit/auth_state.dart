
abstract class AuthState {}

final class AuthInitial extends AuthState {}


final class SignUpLoadingState extends AuthState {}
final class SignUpSuccessState extends AuthState {}
final class SignUpErrorState extends AuthState {
  final String errMessage;

  SignUpErrorState({required this.errMessage});
}
final class TermsAndConditionsUpdateState extends AuthState {}
final class ObscurePasswordTextUpdateState extends AuthState {}
