import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../domain/entities/coffee_entity.dart';
import '../../providers/cart_provider.dart';
import '../../providers/coffee_provider.dart';
import '../../widgets/coffee/category_chip.dart';
import '../../widgets/coffee/coffee_card.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/navigation/app_side_menu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _menuOpen = false;

  void _toggleMenu() => setState(() => _menuOpen = !_menuOpen);
  void _closeMenu() => setState(() => _menuOpen = false);

  @override
  Widget build(BuildContext context) {
    final coffeeState = ref.watch(coffeeProvider);
    final cartState   = ref.watch(cartProvider);

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      child: Stack(
        children: [
          // ── Full-screen coffee beans background ──
          Positioned.fill(
            child: Image.asset(
              "assets/images/coffee_splash.jpg",
              fit: BoxFit.cover,
            ),
          ),
              // Dark overlay
          Positioned.fill(
            child: Container(
              color:  const Color.fromARGB(255, 245, 222, 205).withOpacity(0.55),
            ),
          ),

          // ── Main content ───────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top bar ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimensions.pagePaddingH,
                    AppDimensions.sp16,
                    AppDimensions.pagePaddingH,
                    0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.goodMorning,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.mediumBrown,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.sp2),
                          Text(
                            AppStrings.appName,
                            style: AppTextStyles.brandItalic,
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Cart badge
                      GestureDetector(
                        onTap: () {},
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.beige,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                CupertinoIcons.cart,
                                color: AppColors.primaryBrown,
                                size: 20,
                              ),
                            ),
                            if (cartState.itemCount > 0)
                              Positioned(
                                top: -4,
                                right: -4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${cartState.itemCount}',
                                    style: AppTextStyles.label.copyWith(
                                      color: AppColors.textOnDark,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.sp10),
                      // Menu button
                      GestureDetector(
                        onTap: _toggleMenu,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBrown,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radius10),
                          ),
                          child: const Icon(
                            CupertinoIcons.line_horizontal_3,
                            color: AppColors.textOnDark,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.sp20),

                // ── Search bar ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.pagePaddingH,
                  ),
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.beige,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radius12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: AppDimensions.sp16),
                        const Icon(
                          CupertinoIcons.search,
                          color: AppColors.mediumBrown,
                          size: 18,
                        ),
                        const SizedBox(width: AppDimensions.sp8),
                        Text(
                          AppStrings.searchHint,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.sp20),

                // ── Category chips ──────────────────────────
                SizedBox(
                  height: AppDimensions.categoryChipHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.pagePaddingH,
                    ),
                    itemCount: CoffeeCategory.values.length,
                    itemBuilder: (_, i) {
                      final cat = CoffeeCategory.values[i];
                      return CategoryChip(
                        label: cat.label,
                        isSelected:
                            coffeeState.selectedCategory == cat,
                        onTap: () => ref
                            .read(coffeeProvider.notifier)
                            .selectCategory(cat),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppDimensions.sp20),

                // ── Coffee Grid ─────────────────────────────
                Expanded(
                  child: coffeeState.isLoading
                      ? const LoadingWidget(
                          message: 'Brewing your menu...')
                      : coffeeState.filtered.isEmpty
                          ? Center(
                              child: Text(
                                'No coffees found',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.pagePaddingH,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: AppDimensions.sp12,
                                mainAxisSpacing: AppDimensions.sp16,
                                childAspectRatio: AppDimensions.coffeeCardWidth /
                                    AppDimensions.coffeeCardHeight,
                              ),
                              itemCount: coffeeState.filtered.length,
                              itemBuilder: (_, i) {
                                final coffee =
                                    coffeeState.filtered[i];
                                return CoffeeCard(
                                  coffee: coffee,
                                  onLikeToggle: () => ref
                                      .read(coffeeProvider.notifier)
                                      .toggleLike(coffee.id),
                                  onAddToCart: () => ref
                                      .read(cartProvider.notifier)
                                      .addItem(coffee),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),

          // ── Side menu overlay ──────────────────────────────
          if (_menuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMenu,
                child: Container(
                  color: CupertinoColors.black.withOpacity(0.8),
                ),
              ),
            ),
          if (_menuOpen)
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: AppSideMenu(onClose: _closeMenu),
              ),
            ),
        ],
      ),
    );
  }
}
