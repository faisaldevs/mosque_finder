class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? phone;
  final String? avatar;
  final bool? isVerified;
  final String? role;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.isVerified,
    this.role,
    this.createdAt,
  });

  /// Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'],
      email: json['email'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      isVerified: json['is_verified'] ?? json['isVerified'],
      role: json['role'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'is_verified': isVerified,
      'role': role,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// Create a copy with modified fields
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    bool? isVerified,
    String? role,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      isVerified: isVerified ?? this.isVerified,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
