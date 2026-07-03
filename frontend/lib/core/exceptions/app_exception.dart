/// Base class for all application exceptions.
/// These are user-facing — they carry a [message] suitable for display.
sealed class AppException implements Exception {
  final String message;
  final Object? originalError;
  const AppException(this.message, {this.originalError});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.originalError});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.originalError});
}

class ServerException extends AppException {
  final int? statusCode;
  const ServerException(super.message, {this.statusCode, super.originalError});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.originalError});
}

class UnknownAppException extends AppException {
  const UnknownAppException(super.message, {super.originalError});
}
