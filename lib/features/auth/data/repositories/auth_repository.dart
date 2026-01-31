import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_center/core/errors/failures.dart';
import 'package:medical_center/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:medical_center/generated/l10n.dart';

/// Repository for authentication operations.
///
/// This repository follows clean architecture principles by abstracting
/// the data layer from the presentation layer and handling errors using Either.
abstract class AuthRepository {
  /// Signs up a new user with the provided credentials.
  Future<Either<Failure, void>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    required String bloodType,
    required String image,
  });

  /// Signs in an existing user.
  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  });

  /// Sends a password reset email.
  Future<Either<Failure, void>> resetPassword({required String email});
}

/// Implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, void>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String gender,
    required String bloodType,
    required String image,
  }) async {
    try {
      await _remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _remoteDataSource.createUserProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        gender: gender,
        bloodType: bloodType,
        image: image,
      );

      await _remoteDataSource.createBloodTypeRecord(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        gender: gender,
        bloodType: bloodType,
      );

      await _remoteDataSource.sendEmailVerification();

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
  }) async {
    try {
      await _remoteDataSource.sendPasswordResetEmail(email: email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Handles Firebase authentication exceptions and converts them to failures.
  Failure _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return ServerFailure(message: S.current.weak_password);
      case 'email-already-in-use':
        return ServerFailure(message: S.current.account_already_exists);
      case 'invalid-email':
        return ServerFailure(message: S.current.invalid_email);
      case 'user-not-found':
        return ServerFailure(message: S.current.no_user_found);
      case 'wrong-password':
        return ServerFailure(message: S.current.wrong_password);
      default:
        return ServerFailure(
          message: S.current.check_your_email_and_password,
        );
    }
  }
}
