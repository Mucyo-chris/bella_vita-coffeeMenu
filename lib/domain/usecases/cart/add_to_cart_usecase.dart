// lib/domain/usecases/cart/add_to_cart_usecase.dart
import '../../entities/coffee_entity.dart';
import '../../entities/cart_item_entity.dart';

class AddToCartUseCase {
  final List<CartItemEntity> _cart;
  const AddToCartUseCase(this._cart);

  List<CartItemEntity> call(CoffeeEntity coffee) {
    final idx = _cart.indexWhere((i) => i.coffee.id == coffee.id);
    if (idx != -1) {
      final updated = List<CartItemEntity>.from(_cart);
      updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity + 1);
      return updated;
    }
    return [
      ..._cart,
      CartItemEntity(
        id: 'cart_${coffee.id}_${DateTime.now().millisecondsSinceEpoch}',
        coffee: coffee,
        quantity: 1,
      ),
    ];
  }
}
