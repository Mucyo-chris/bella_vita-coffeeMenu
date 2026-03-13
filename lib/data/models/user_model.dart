// lib/data/models/user_model.dart
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    super.avatarUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        avatarUrl: map['avatarUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'email': email,
        if (avatarUrl != null) 'avatarUrl': avatarUrl,
      };
}
