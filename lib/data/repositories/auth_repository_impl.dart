// lib/data/repositories/auth_repository_impl.dart
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_local_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalSource _source;
  const AuthRepositoryImpl(this._source);

  @override
  UserEntity? get currentUser => _source.currentUser;

  @override
  bool get isLoggedIn => _source.currentUser != null;

  @override
  Future<UserEntity> signInWithEmail(String emailOrPhone) =>
      _source.signIn(emailOrPhone);

  @override
  Future<UserEntity> signUp({
    required String username,
    required String email,
    required String password,
  }) =>
      _source.signUp(username: username, email: email, password: password);

  @override
  Future<void> logout() => _source.logout();
}
