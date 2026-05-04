class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
