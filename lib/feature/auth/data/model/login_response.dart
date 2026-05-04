import 'package:mosque_finder_app/feature/auth/data/model/user_model.dart';

class LoginResponse {
  final String accessToken;
  final String? refreshToken;
  final UserModel user;
  final int? expiresIn;

  LoginResponse({
    required this.accessToken,
    this.refreshToken,
    required this.user,
    this.expiresIn,
  });

  /// Factory constructor to create LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? json['accessToken'] ?? '',
      refreshToken: json['refresh_token'] ?? json['refreshToken'],
      user: UserModel.fromJson(json['user'] ?? {}),
      expiresIn: json['expires_in'] ?? json['expiresIn'],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user': user.toJson(),
      'expires_in': expiresIn,
    };
  }
}
