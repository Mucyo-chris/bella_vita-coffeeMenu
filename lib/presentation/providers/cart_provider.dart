import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/coffee_entity.dart';
import '../../domain/usecases/cart/add_to_cart_usecase.dart';
import '../../domain/usecases/cart/remove_from_cart_usecase.dart';

// ── State ─────────────────────────────────────────────────────
class CartState {
  final List<CartItemEntity> items;

  const CartState({this.items = const []});

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
  double get total => items.fold(0.0, (sum, i) => sum + i.subtotal);
  bool get isEmpty => items.isEmpty;

  int quantityOf(String coffeeId) {
    final idx = items.indexWhere((i) => i.coffee.id == coffeeId);
    return idx != -1 ? items[idx].quantity : 0;
  }

  CartState copyWith({List<CartItemEntity>? items}) =>
      CartState(items: items ?? this.items);
}

// ── Notifier ──────────────────────────────────────────────────
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  static const _removeUseCase = RemoveFromCartUseCase();

  void addItem(CoffeeEntity coffee) {
    final useCase = AddToCartUseCase(state.items);
    final updated = useCase.call(coffee);
    state = state.copyWith(items: updated);
  }

  void decrementItem(String cartItemId) {
    final updated = _removeUseCase.call(
      state.items,
      cartItemId,
      removeAll: false,
    );
    state = state.copyWith(items: updated);
  }

  void removeItem(String cartItemId) {
    final updated = _removeUseCase.call(
      state.items,
      cartItemId,
      removeAll: true,
    );
    state = state.copyWith(items: updated);
  }

  void clear() => state = const CartState();
}

// ── Provider ──────────────────────────────────────────────────
final cartProvider =
    StateNotifierProvider<CartNotifier, CartState>(
  (_) => CartNotifier(),
);
