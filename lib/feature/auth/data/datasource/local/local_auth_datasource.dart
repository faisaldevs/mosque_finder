import 'package:mosque_finder_app/feature/auth/data/model/user_model.dart';

/// Interface for local authentication data source
abstract class LocalAuthDatasource {
  /// Save authentication token and user data
  Future<void> saveToken(String accessToken, {String? refreshToken});

  /// Save user data locally
  Future<void> saveUser(UserModel user);

  /// Retrieve the stored access token
  Future<String?> getAccessToken();

  /// Retrieve the stored refresh token
  Future<String?> getRefreshToken();

  /// Retrieve stored user data
  Future<UserModel?> getUser();

  /// Check if user is authenticated (token exists)
  Future<bool> isLoggedIn();

  /// Clear all authentication data (logout)
  Future<void> clearAuth();

  /// Update access token (for refresh)
  Future<void> updateAccessToken(String newAccessToken);
}
