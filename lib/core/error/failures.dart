import 'package:equatable/equatable.dart';

/// Base failure class for domain errors
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred'])
      : super(message);
}

/// Cache/local storage failures
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred'])
      : super(message);
}

/// Database failures
class DatabaseFailure extends Failure {
  const DatabaseFailure([String message = 'Database error occurred'])
      : super(message);
}

/// Network connectivity failures
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network error occurred'])
      : super(message);
}

/// Validation failures
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure([
    String message = 'Validation failed',
    this.fieldErrors,
  ]) : super(message);

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Resource not found'])
      : super(message);
}

/// Permission/authorization failures
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permission denied'])
      : super(message);
}

/// File operation failures
class FileFailure extends Failure {
  const FileFailure([String message = 'File operation failed'])
      : super(message);
}

/// Import/parsing failures
class ImportFailure extends Failure {
  final int? rowNumber;

  const ImportFailure([
    String message = 'Import failed',
    this.rowNumber,
  ]) : super(message);

  @override
  List<Object?> get props => [message, rowNumber];
}

/// Duplicate entry failures
class DuplicateFailure extends Failure {
  const DuplicateFailure([String message = 'Duplicate entry found'])
      : super(message);
}

/// Unknown/unexpected failures
class UnknownFailure extends Failure {
  final Object? originalError;

  const UnknownFailure([
    String message = 'An unexpected error occurred',
    this.originalError,
  ]) : super(message);

  @override
  List<Object?> get props => [message, originalError];
}

