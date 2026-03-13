import '../../domain/entities/coffee_entity.dart';
import '../../domain/repositories/coffee_repository.dart';
import '../sources/coffee_local_source.dart';

class CoffeeRepositoryImpl implements CoffeeRepository {
  final CoffeeLocalSource _source;
  const CoffeeRepositoryImpl(this._source);

  @override
  Future<List<CoffeeEntity>> getCoffees() => _source.getAll();

  @override
  Future<List<CoffeeEntity>> getCoffeesByCategory(
      CoffeeCategory category) async {
    final all = await _source.getAll();
    return all.where((c) => c.category == category).toList();
  }

  @override
  Future<CoffeeEntity> toggleLike(String coffeeId) =>
      _source.toggleLike(coffeeId);

  @override
  Future<List<CoffeeEntity>> getLikedCoffees() async {
    final all = await _source.getAll();
    return all.where((c) => c.isLiked).toList();
  }
}
