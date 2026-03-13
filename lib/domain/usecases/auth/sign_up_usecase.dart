import '../../repositories/auth_repository.dart';
import '../../entities/user_entity.dart';

class SignUpUseCase {
  final AuthRepository _repository;
  const SignUpUseCase(this._repository);

  Future<UserEntity> call({
    required String username,
    required String email,
    required String password,
  }) =>
      _repository.signUp(
        username: username,
        email: email,
        password: password,
      );
}
