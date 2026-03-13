import '../models/user_model.dart';

abstract class AuthLocalSource {
  Future<UserModel> signIn(String emailOrPhone);
  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<void> logout();
  UserModel? get currentUser;
}

class AuthLocalSourceImpl implements AuthLocalSource {
  UserModel? _currentUser;

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Future<UserModel> signIn(String emailOrPhone) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _currentUser = UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      username: emailOrPhone.contains('@')
          ? emailOrPhone.split('@').first
          : emailOrPhone,
      email: emailOrPhone.contains('@')
          ? emailOrPhone
          : '$emailOrPhone@bellavita.app',
    );
    return _currentUser!;
  }

  @override
  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _currentUser = UserModel(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}',
      username: username,
      email: email,
    );
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
  }
}
