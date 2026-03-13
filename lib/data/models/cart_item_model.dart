import '../../domain/entities/cart_item_entity.dart';
import 'coffee_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.coffee,
    super.quantity,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel(
        id: map['id'] as String,
        coffee: CoffeeModel.fromMap(map['coffee'] as Map<String, dynamic>),
        quantity: map['quantity'] as int? ?? 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'coffee': (coffee as CoffeeModel).toMap(),
        'quantity': quantity,
      };

  @override
  CartItemModel copyWith({
    String? id,
    covariant CoffeeModel? coffee,
    int? quantity,
  }) =>
      CartItemModel(
        id: id ?? this.id,
        coffee: coffee ?? this.coffee,
        quantity: quantity ?? this.quantity,
      );
}
