import 'package:dio/dio.dart';
import 'package:mosque_finder_app/core/networks/endpoints.dart';
import 'package:mosque_finder_app/core/networks/exception_handler/auth_exceptions.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/remote/remote_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/model/login_request.dart';
import 'package:mosque_finder_app/feature/auth/data/model/login_response.dart';

/// Implementation of RemoteAuthDatasource using Dio HTTP client
class RemoteAuthDatasourceImpl implements RemoteAuthDatasource {
  final Dio _dio;

  RemoteAuthDatasourceImpl(this._dio);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        Endpoints.login(),
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      }

      throw InvalidCredentialsException(
        'Login failed: ${response.statusMessage}',
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw AuthFailedException(
        'Unexpected error during login: ${e.toString()}',
      );
    }
  }

  @override
  Future<LoginResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        Endpoints.login(), // Adjust endpoint if API has separate refresh endpoint
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      }

      throw TokenExpiredException(
        'Token refresh failed: ${response.statusMessage}',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw TokenExpiredException('Refresh token expired');
      }
      throw _handleDioException(e);
    } catch (e) {
      throw AuthFailedException(
        'Unexpected error during token refresh: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> logout(String token) async {
    try {
      await _dio.post(
        Endpoints.logout(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // ignore: unused_catch_clause
    } on DioException catch (e) {
      // For logout, we don't throw - just log the error
      // User should still be logged out locally even if API fails
      // throw _handleDioException(e);
    } catch (e) {
      // Silently fail logout to prevent blocking user
    }
  }

  /// Convert DioException to AuthException
  AuthException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.statusMessage ?? 'Request failed';

        if (statusCode == 401) {
          return UnauthorizedException('Unauthorized: $message');
        } else if (statusCode == 400) {
          return InvalidCredentialsException('Invalid credentials: $message');
        } else if (statusCode == 403) {
          return UnauthorizedException('Access forbidden: $message');
        } else {
          return AuthFailedException('Error: $message');
        }

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException(
          'Network timeout. Please check your connection',
        );

      case DioExceptionType.unknown:
        return NetworkException('Network error: ${e.message}');

      case DioExceptionType.cancel:
        return NetworkException('Request cancelled');

      default:
        return NetworkException('Network error occurred: ${e.message}');
    }
  }
}
