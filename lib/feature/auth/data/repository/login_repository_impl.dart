import 'package:mosque_finder_app/feature/auth/data/datasource/local/local_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/remote/remote_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/model/login_request.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/login_repository.dart';
import 'package:mosque_finder_app/feature/auth/data/repository/user_entity.dart';

/// Implementation of LoginRepository
/// Combines remote API calls with local storage for authentication
class LoginRepositoryImpl implements LoginRepository {
  final RemoteAuthDatasource _remoteDataSource;
  final LocalAuthDatasource _localDataSource;

  LoginRepositoryImpl({
    required RemoteAuthDatasource remoteDataSource,
    required LocalAuthDatasource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<User> login(String email, String password) async {
    // Call API to login
    final response = await _remoteDataSource.login(
      LoginRequest(email: email, password: password),
    );

    // Save tokens and user data locally
    await _localDataSource.saveToken(
      response.accessToken,
      refreshToken: response.refreshToken,
    );
    await _localDataSource.saveUser(response.user);

    // Return user entity
    return User.fromModel(response.user);
  }

  @override
  Future<User> refreshToken() async {
    // Get stored refresh token
    final storedRefreshToken = await _localDataSource.getRefreshToken();

    if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }

    // Call API to refresh token
    final response = await _remoteDataSource.refreshToken(storedRefreshToken);

    // Update stored tokens
    await _localDataSource.saveToken(
      response.accessToken,
      refreshToken: response.refreshToken,
    );

    // Update user data if provided
    await _localDataSource.saveUser(response.user);

    return User.fromModel(response.user);
  }

  @override
  Future<void> logout() async {
    try {
      // Get current token for API call
      final token = await _localDataSource.getAccessToken();

      if (token != null) {
        // Call logout endpoint
        await _remoteDataSource.logout(token);
      }
    } catch (e) {
      // Log but don't fail - we should clear locally anyway
      // ignore: avoid_print
      print('Error calling logout API: $e');
    } finally {
      // Always clear local data
      await _localDataSource.clearAuth();
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _localDataSource.isLoggedIn();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await _localDataSource.getUser();
    if (userModel == null) return null;
    return User.fromModel(userModel);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _localDataSource.getAccessToken();
  }
}
