// lib/domain/usecases/coffee/toggle_like_usecase.dart
import '../../repositories/coffee_repository.dart';
import '../../entities/coffee_entity.dart';

class ToggleLikeUseCase {
  final CoffeeRepository _repository;
  const ToggleLikeUseCase(this._repository);

  Future<CoffeeEntity> call(String coffeeId) =>
      _repository.toggleLike(coffeeId);
}
