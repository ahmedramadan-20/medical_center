import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';
import 'package:medical_center/features/auth/data/repositories/auth_repository.dart';

/// Use case for password reset.
class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  ResetPasswordUseCase({required AuthRepository repository})
      : _repository = repository;
  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async =>
      _repository.resetPassword(email: params.email);
}

/// Parameters for the reset password use case.
class ResetPasswordParams extends Equatable {
  const ResetPasswordParams({required this.email});
  final String email;

  @override
  List<Object?> get props => [email];
}
