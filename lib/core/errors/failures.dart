import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Failures represent errors that have been processed and
/// are ready to be presented to the user.
abstract class Failure extends Equatable {
  const Failure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Failure for server-related errors.
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

/// Failure for cache-related errors.
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
