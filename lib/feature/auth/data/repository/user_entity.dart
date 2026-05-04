import 'package:mosque_finder_app/feature/auth/data/model/user_model.dart';

/// User entity - represents authenticated user in domain layer
class User {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? avatar;
  final bool isVerified;

  User({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.avatar,
    this.isVerified = false,
  });

  /// Create User from UserModel
  factory User.fromModel(UserModel model) {
    return User(
      id: model.id,
      email: model.email,
      name: model.name,
      phone: model.phone,
      avatar: model.avatar,
      isVerified: model.isVerified ?? false,
    );
  }
}
