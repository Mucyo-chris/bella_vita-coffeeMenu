import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/responsive.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/common/app_button.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final r    = context.r;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.cream.withOpacity(0.85),
        border: null,
        middle: Text(AppStrings.myCart, style: AppTextStyles.titleMedium),
        trailing: cart.isEmpty
            ? null
            : GestureDetector(
                onTap: () => ref.read(cartProvider.notifier).clear(),
                child: Text(
                  'Clear',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background image ─────────────────────────────
          Positioned.fill(
            child: Image.asset(
              'assets/images/coffee_splash.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.beige),
            ),
          ),

          // ── Cream overlay so content stays readable ──────
          Positioned.fill(
            child: Container(
              color: AppColors.cream.withOpacity(0.88),
            ),
          ),

          // ── Main content ─────────────────────────────────
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                child: cart.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.cart_badge_minus,
                              size: r.sp(60),
                              color: AppColors.lightBrown,
                            ),
                            SizedBox(height: r.sp(16)),
                            Text(
                              AppStrings.emptyCart,
                              style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.mediumBrown,
                                  fontSize: r.fs(16)),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          // ── Items list ───────────────────
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.all(r.pagePadH),
                              itemCount: cart.items.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: r.sp(10)),
                              itemBuilder: (_, i) {
                                final item = cart.items[i];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.cream.withOpacity(0.92),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryBrown
                                            .withOpacity(0.08),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(r.sp(12)),
                                    child: Row(
                                      children: [
                                        // Coffee thumbnail
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            width: r.sp(64),
                                            height: r.sp(64),
                                            child: Image.asset(
                                              item.coffee.imageAsset,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  Container(
                                                color: AppColors.mediumBrown,
                                                child: Center(
                                                  child: Text('☕',
                                                      style: TextStyle(
                                                          fontSize: r.fs(24))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: r.sp(12)),

                                        // Name + price
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(item.coffee.name,
                                                  style: AppTextStyles
                                                      .titleSmall
                                                      .copyWith(
                                                          fontSize: r.fs(14))),
                                              SizedBox(height: r.sp(4)),
                                              Text(
                                                item.coffee.price.asPrice,
                                                style: AppTextStyles.bodySmall
                                                    .copyWith(
                                                  color: AppColors.mediumBrown,
                                                  fontSize: r.fs(12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Qty controls
                                        Row(
                                          children: [
                                            _QtyBtn(
                                              icon: CupertinoIcons.minus,
                                              size: r.sp(30),
                                              iconSize: r.fs(14),
                                              onTap: () => ref
                                                  .read(cartProvider.notifier)
                                                  .decrementItem(item.id),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: r.sp(10)),
                                              child: Text(
                                                '${item.quantity}',
                                                style: AppTextStyles.titleSmall
                                                    .copyWith(
                                                        fontSize: r.fs(15)),
                                              ),
                                            ),
                                            _QtyBtn(
                                              icon: CupertinoIcons.add,
                                              size: r.sp(30),
                                              iconSize: r.fs(14),
                                              onTap: () => ref
                                                  .read(cartProvider.notifier)
                                                  .addItem(item.coffee),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // ── Total + Checkout ─────────────
                          Container(
                            padding: EdgeInsets.all(r.pagePadH),
                            decoration: BoxDecoration(
                              color: AppColors.cream.withOpacity(0.95),
                              border: Border(
                                top: BorderSide(
                                    color: AppColors.beige, width: 1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryBrown
                                      .withOpacity(0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(AppStrings.total,
                                        style: AppTextStyles.titleMedium
                                            .copyWith(fontSize: r.fs(16))),
                                    Text(
                                      cart.total.asPrice,
                                      style: AppTextStyles.titleMedium
                                          .copyWith(
                                        color: AppColors.primaryBrown,
                                        fontWeight: FontWeight.w700,
                                        fontSize: r.fs(18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: r.sp(16)),
                                AppButton(
                                  label: AppStrings.checkout,
                                  height: r.buttonHeight,
                                  onTap: () => context.push(
                                    AppRoutes.paymentSelect,
                                    extra: cart.total,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const _QtyBtn({
    required this.icon,
    required this.onTap,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.primaryBrown,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textOnDark, size: iconSize),
      ),
    );
  }
}