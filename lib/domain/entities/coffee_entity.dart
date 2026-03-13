import 'package:equatable/equatable.dart';

enum CoffeeCategory { all, espresso, cappuccino, americano }

extension CoffeeCategoryLabel on CoffeeCategory {
  String get label {
    switch (this) {
      case CoffeeCategory.all:        return 'ALL';
      case CoffeeCategory.espresso:   return 'Espresso';
      case CoffeeCategory.cappuccino: return 'Cappuccino';
      case CoffeeCategory.americano:  return 'Americano';
    }
  }
}

class CoffeeEntity extends Equatable {
  final String id;
  final String name;
  final String imageAsset;
  final double price;
  final CoffeeCategory category;
  final double rating;
  final String description;
  final bool isLiked;

  const CoffeeEntity({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.price,
    required this.category,
    this.rating = 4.5,
    this.description = '',
    this.isLiked = false,
  });

  CoffeeEntity copyWith({
    String? id,
    String? name,
    String? imageAsset,
    double? price,
    CoffeeCategory? category,
    double? rating,
    String? description,
    bool? isLiked,
  }) {
    return CoffeeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageAsset: imageAsset ?? this.imageAsset,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, imageAsset, price, category, rating, description, isLiked];
}
