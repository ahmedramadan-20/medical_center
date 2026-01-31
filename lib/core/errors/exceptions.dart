import 'package:equatable/equatable.dart';

/// Base exception class for server-related errors.
///
/// This exception is thrown when there are issues communicating
/// with remote services or APIs.
class ServerException extends Equatable implements Exception {
  const ServerException(this.message);
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

/// Exception thrown when cache operations fail.
///
/// This exception is thrown when there are issues with local
/// storage or cache operations.
class CacheException extends Equatable implements Exception {
  const CacheException(this.message);
  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}
