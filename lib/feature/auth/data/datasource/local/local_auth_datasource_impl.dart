import 'dart:convert';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mosque_finder_app/feature/auth/data/datasource/local/local_auth_datasource.dart';
import 'package:mosque_finder_app/feature/auth/data/model/user_model.dart';

/// Implementation of LocalAuthDatasource using Hive for local storage
class LocalAuthDatasourceImpl implements LocalAuthDatasource {
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _userKey = 'auth_user';

  final Box _hiveBox;

  LocalAuthDatasourceImpl(this._hiveBox);

  @override
  Future<void> saveToken(String accessToken, {String? refreshToken}) async {
    await _hiveBox.put(_accessTokenKey, accessToken);
    if (refreshToken != null) {
      await _hiveBox.put(_refreshTokenKey, refreshToken);
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _hiveBox.put(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<String?> getAccessToken() async {
    final token = _hiveBox.get(_accessTokenKey);
    return token as String?;
  }

  @override
  Future<String?> getRefreshToken() async {
    final token = _hiveBox.get(_refreshTokenKey);
    return token as String?;
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = _hiveBox.get(_userKey);
    if (userJson == null) return null;

    try {
      final decoded = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearAuth() async {
    await Future.wait([
      _hiveBox.delete(_accessTokenKey),
      _hiveBox.delete(_refreshTokenKey),
      _hiveBox.delete(_userKey),
    ]);
  }

  @override
  Future<void> updateAccessToken(String newAccessToken) async {
    await _hiveBox.put(_accessTokenKey, newAccessToken);
  }
}
