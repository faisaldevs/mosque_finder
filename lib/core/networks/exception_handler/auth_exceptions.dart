import 'package:mosque_finder_app/core/networks/exception_handler/data_source.dart';

/// Base exception for authentication errors
abstract class AuthException implements Exception {
  final String message;
  final Failure? failure;

  AuthException(this.message, {this.failure});

  @override
  String toString() => message;
}

/// Thrown when authentication is required but not provided (401)
class UnauthorizedException extends AuthException {
  UnauthorizedException(super.message, {super.failure});
}

/// Thrown when credentials are invalid (wrong email/password)
class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(super.message, {super.failure});
}

/// Thrown when the auth token has expired
class TokenExpiredException extends AuthException {
  TokenExpiredException(super.message, {super.failure});
}

/// Thrown when there's a network-related error
class NetworkException extends AuthException {
  NetworkException(super.message, {super.failure});
}

/// Thrown for generic auth errors
class AuthFailedException extends AuthException {
  AuthFailedException(super.message, {super.failure});
}
