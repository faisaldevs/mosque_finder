import 'package:mosque_finder_app/feature/auth/data/model/login_request.dart';
import 'package:mosque_finder_app/feature/auth/data/model/login_response.dart';

/// Interface for remote authentication data source (API calls)
abstract class RemoteAuthDatasource {
  /// Call login endpoint with email and password
  /// Throws [UnauthorizedException] on 401
  /// Throws [InvalidCredentialsException] on 400 or invalid credentials
  /// Throws [NetworkException] on network errors
  Future<LoginResponse> login(LoginRequest request);

  /// Call refresh token endpoint to get new access token
  Future<LoginResponse> refreshToken(String refreshToken);

  /// Call logout endpoint to invalidate token
  Future<void> logout(String token);
}
