import 'package:equatable/equatable.dart';
import 'coffee_entity.dart';

class CartItemEntity extends Equatable {
  final String id;
  final CoffeeEntity coffee;
  final int quantity;

  const CartItemEntity({
    required this.id,
    required this.coffee,
    this.quantity = 1,
  });

  double get subtotal => coffee.price * quantity;

  CartItemEntity copyWith({
    String? id,
    CoffeeEntity? coffee,
    int? quantity,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      coffee: coffee ?? this.coffee,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, coffee, quantity];
}
