// lib/domain/usecases/coffee/get_coffees_usecase.dart
import '../../repositories/coffee_repository.dart';
import '../../entities/coffee_entity.dart';

class GetCoffeesUseCase {
  final CoffeeRepository _repository;
  const GetCoffeesUseCase(this._repository);

  Future<List<CoffeeEntity>> call([CoffeeCategory category = CoffeeCategory.all]) {
    if (category == CoffeeCategory.all) return _repository.getCoffees();
    return _repository.getCoffeesByCategory(category);
  }
}
