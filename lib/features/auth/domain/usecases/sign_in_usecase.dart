import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';
import 'package:medical_center/features/auth/data/repositories/auth_repository.dart';

/// Use case for user authentication (sign in).
class SignInUseCase implements UseCase<void, SignInParams> {
  SignInUseCase({required AuthRepository repository})
      : _repository = repository;
  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(SignInParams params) async =>
      _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

/// Parameters for the sign in use case.
class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
