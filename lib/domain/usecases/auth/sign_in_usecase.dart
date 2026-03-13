// lib/domain/usecases/auth/sign_in_usecase.dart
import '../../repositories/auth_repository.dart';
import '../../entities/user_entity.dart';

class SignInUseCase {
  final AuthRepository _repository;
  const SignInUseCase(this._repository);

  Future<UserEntity> call(String emailOrPhone) =>
      _repository.signInWithEmail(emailOrPhone);
}
