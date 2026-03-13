import '../../domain/entities/coffee_entity.dart';

class CoffeeModel extends CoffeeEntity {
  const CoffeeModel({
    required super.id,
    required super.name,
    required super.imageAsset,
    required super.price,
    required super.category,
    super.rating,
    super.description,
    super.isLiked,
  });

  factory CoffeeModel.fromMap(Map<String, dynamic> map) => CoffeeModel(
        id: map['id'] as String,
        name: map['name'] as String,
        imageAsset: map['imageAsset'] as String,
        price: (map['price'] as num).toDouble(),
        category: CoffeeCategory.values.firstWhere(
          (e) => e.name == map['category'],
          orElse: () => CoffeeCategory.all,
        ),
        rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
        description: map['description'] as String? ?? '',
        isLiked: map['isLiked'] as bool? ?? false,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'imageAsset': imageAsset,
        'price': price,
        'category': category.name,
        'rating': rating,
        'description': description,
        'isLiked': isLiked,
      };

  @override
  CoffeeModel copyWith({
    String? id,
    String? name,
    String? imageAsset,
    double? price,
    CoffeeCategory? category,
    double? rating,
    String? description,
    bool? isLiked,
  }) =>
      CoffeeModel(
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
