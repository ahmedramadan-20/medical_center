import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/core/usecases/usecase.dart';
import 'package:medical_center/features/auth/data/repositories/auth_repository.dart';

/// Use case for user registration.
///
/// This use case encapsulates the business logic for signing up a new user,
/// following the clean architecture pattern.
class SignUpUseCase implements UseCase<void, SignUpParams> {
  SignUpUseCase({required AuthRepository repository})
      : _repository = repository;
  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async =>
      _repository.signUp(
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
        password: params.password,
        phone: params.phone,
        gender: params.gender,
        bloodType: params.bloodType,
        image: params.image,
      );
}

/// Parameters for the sign up use case.
class SignUpParams extends Equatable {
  const SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.gender,
    required this.bloodType,
    required this.image,
  });
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String gender;
  final String bloodType;
  final String image;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        phone,
        gender,
        bloodType,
        image,
      ];
}
