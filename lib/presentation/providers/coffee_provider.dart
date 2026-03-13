import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/coffee_entity.dart';
import '../../injection/dependency_injection.dart';

// ── State ─────────────────────────────────────────────────────
class CoffeeState {
  final List<CoffeeEntity> coffees;
  final CoffeeCategory selectedCategory;
  final bool isLoading;
  final String? error;

  const CoffeeState({
    this.coffees = const [],
    this.selectedCategory = CoffeeCategory.all,
    this.isLoading = false,
    this.error,
  });

  List<CoffeeEntity> get filtered {
    if (selectedCategory == CoffeeCategory.all) return coffees;
    return coffees.where((c) => c.category == selectedCategory).toList();
  }

  List<CoffeeEntity> get liked => coffees.where((c) => c.isLiked).toList();

  CoffeeState copyWith({
    List<CoffeeEntity>? coffees,
    CoffeeCategory? selectedCategory,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      CoffeeState(
        coffees: coffees ?? this.coffees,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : error ?? this.error,
      );
}

// ── Notifier ──────────────────────────────────────────────────
class CoffeeNotifier extends StateNotifier<CoffeeState> {
  final Ref _ref;

  CoffeeNotifier(this._ref) : super(const CoffeeState()) {
    loadCoffees();
  }

  Future<void> loadCoffees() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final coffees =
          await _ref.read(getCoffeesUseCaseProvider).call();
      state = state.copyWith(coffees: coffees, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectCategory(CoffeeCategory category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> toggleLike(String coffeeId) async {
    try {
      final updated =
          await _ref.read(toggleLikeUseCaseProvider).call(coffeeId);
      final newList = state.coffees.map((c) {
        return c.id == updated.id ? updated : c;
      }).toList();
      state = state.copyWith(coffees: newList);
    } catch (_) {}
  }
}

// ── Provider ──────────────────────────────────────────────────
final coffeeProvider =
    StateNotifierProvider<CoffeeNotifier, CoffeeState>(
  (ref) => CoffeeNotifier(ref),
);
