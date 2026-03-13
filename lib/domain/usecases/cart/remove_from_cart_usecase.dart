// lib/domain/usecases/cart/remove_from_cart_usecase.dart
import '../../entities/cart_item_entity.dart';

class RemoveFromCartUseCase {
  const RemoveFromCartUseCase();

  List<CartItemEntity> call(
      List<CartItemEntity> cart, String cartItemId,
      {bool removeAll = false}) {
    final idx = cart.indexWhere((i) => i.id == cartItemId);
    if (idx == -1) return cart;
    final updated = List<CartItemEntity>.from(cart);
    if (!removeAll && updated[idx].quantity > 1) {
      updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity - 1);
    } else {
      updated.removeAt(idx);
    }
    return updated;
  }
}
