import '../entities/coffee_entity.dart';

abstract class CoffeeRepository {
  Future<List<CoffeeEntity>> getCoffees();
  Future<List<CoffeeEntity>> getCoffeesByCategory(CoffeeCategory category);
  Future<CoffeeEntity> toggleLike(String coffeeId);
  Future<List<CoffeeEntity>> getLikedCoffees();
}
