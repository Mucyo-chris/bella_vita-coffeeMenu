// lib/domain/repositories/auth_repository.dart
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithEmail(String emailOrPhone);
  Future<UserEntity> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<void> logout();
  UserEntity? get currentUser;
  bool get isLoggedIn;
}
