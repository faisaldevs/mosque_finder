import 'package:mosque_finder_app/feature/auth/data/repository/user_entity.dart';

/// Interface for login repository
abstract class LoginRepository {
  /// Login with email and password
  /// Returns User on success
  /// Throws AuthException on failure
  Future<User> login(String email, String password);

  /// Refresh access token using stored refresh token
  /// Returns User on success
  /// Throws TokenExpiredException if refresh token is invalid
  Future<User> refreshToken();

  /// Logout current user
  /// Clears stored tokens and user data
  Future<void> logout();

  /// Check if user is currently logged in
  Future<bool> isLoggedIn();

  /// Get current logged-in user
  Future<User?> getCurrentUser();

  /// Get stored access token
  Future<String?> getAccessToken();
}
