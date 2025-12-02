/// Base exception class for data layer errors
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => '$runtimeType: $message';
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException([String message = 'Server error occurred'])
      : super(message);
}

/// Cache/local storage exceptions
class CacheException extends AppException {
  const CacheException([String message = 'Cache error occurred'])
      : super(message);
}

/// Database exceptions
class DatabaseException extends AppException {
  const DatabaseException([String message = 'Database error occurred'])
      : super(message);
}

/// Not found exceptions
class NotFoundException extends AppException {
  const NotFoundException([String message = 'Resource not found'])
      : super(message);
}

/// Validation exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException([
    String message = 'Validation failed',
    this.fieldErrors,
  ]) : super(message);
}

/// File operation exceptions
class FileException extends AppException {
  const FileException([String message = 'File operation failed'])
      : super(message);
}

/// Import/parsing exceptions
class ImportException extends AppException {
  final int? rowNumber;

  const ImportException([
    String message = 'Import failed',
    this.rowNumber,
  ]) : super(message);
}

/// Duplicate entry exceptions
class DuplicateException extends AppException {
  const DuplicateException([String message = 'Duplicate entry found'])
      : super(message);
}

