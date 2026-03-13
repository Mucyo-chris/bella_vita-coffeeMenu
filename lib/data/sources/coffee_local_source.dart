// lib/data/sources/coffee_local_source.dart
import '../models/coffee_model.dart';
import '../../domain/entities/coffee_entity.dart';

abstract class CoffeeLocalSource {
  Future<List<CoffeeModel>> getAll();
  Future<CoffeeModel> toggleLike(String id);
}

class CoffeeLocalSourceImpl implements CoffeeLocalSource {
  // Seed data mirrors the provided UI designs
  final List<CoffeeModel> _coffees = [
    const CoffeeModel(
      id: 'c1',
      name: 'Espresso dark',
      imageAsset: 'assets/images/espresso_dark.jpg',
      price: 3500,
      category: CoffeeCategory.espresso,
      rating: 4.8,
      description: 'Rich, bold single-origin espresso shot with a smooth crema.',
      isLiked: true,
    ),
     const CoffeeModel(
      id: 'c2',
      name: 'Espresso Milk',
      imageAsset: 'assets/images/espresso_pour.jpg',
      price: 4500,
      category: CoffeeCategory.espresso,
      rating: 4.6,
      description: 'Pure, uncut espresso — intense and aromatic.',
    ),
    const CoffeeModel(
      id: 'c3',
      name: 'Cappuccino',
      imageAsset: 'assets/images/cappuccino.jpg',
      price: 4000,
      category: CoffeeCategory.cappuccino,
      rating: 4.7,
      description: 'Classic Italian cappuccino with velvety steamed milk foam.',
      isLiked: true,
    ),
    const CoffeeModel(
      id: 'c4',
      name: 'Americano',
      imageAsset: 'assets/images/americano.jpg',
      price: 3.75,
      category: CoffeeCategory.americano,
      rating: 4.5,
      description: 'Espresso diluted with hot water for a lighter, longer sip.',
    ),
    const CoffeeModel(
      id: 'c5',
      name: 'Latte Art',
      imageAsset: 'assets/images/latte_art.jpg',
      price: 4500,
      category: CoffeeCategory.cappuccino,
      rating: 4.9,
      description: 'Silky latte crowned with hand-crafted latte art.',
    ),
    const CoffeeModel(
      id: 'c6',
      name: 'Cold Brew',
      imageAsset: 'assets/images/cappuccino_lattle.jpg',
      price: 4250,
      category: CoffeeCategory.americano,
      rating: 4.7,
      description: '12-hour cold-steeped concentrate, smooth with low acidity.',
    ),
    const CoffeeModel(
      id: 'c7',
      name: 'Igikoma',
      imageAsset: 'assets/images/cappuccino_top.jpg',
      price: 4750,
      category: CoffeeCategory.espresso,
      rating: 4.7,
      description: '12-hour cold-steeped concentrate, smooth with low acidity.',
    ),
    const CoffeeModel(
      id: 'c8',
      name: 'Mukaru',
      imageAsset: 'assets/images/espresso_dark.jpg',
      price: 2500,
      category: CoffeeCategory.espresso,
      rating: 4.7,
      description: '12-hour cold-steeped concentrate, smooth with low acidity.',
    ),
  ];

  @override
  Future<List<CoffeeModel>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_coffees);
  }

  @override
  Future<CoffeeModel> toggleLike(String id) async {
    final idx = _coffees.indexWhere((c) => c.id == id);
    if (idx == -1) throw StateError('Coffee not found: $id');
    final updated = _coffees[idx].copyWith(isLiked: !_coffees[idx].isLiked);
    _coffees[idx] = updated as CoffeeModel;
    return _coffees[idx];
  }
}
