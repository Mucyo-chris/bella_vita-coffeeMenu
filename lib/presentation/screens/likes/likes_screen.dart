import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/responsive.dart';
import '../../providers/cart_provider.dart';
import '../../providers/coffee_provider.dart';

class LikesScreen extends ConsumerWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(coffeeProvider).liked;
    final r     = context.r;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.cream.withOpacity(0.85),
        border: null,
        middle: Text('Favourites', style: AppTextStyles.titleMedium),
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

          // ── Cream overlay ────────────────────────────────
          Positioned.fill(
            child: Container(color: AppColors.cream.withOpacity(0.88)),
          ),

          // ── Content ──────────────────────────────────────
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                child: liked.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.heart_slash,
                              size: r.sp(56),
                              color: AppColors.lightBrown,
                            ),
                            SizedBox(height: r.sp(16)),
                            Text(
                              'No favourites yet',
                              style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.mediumBrown,
                                  fontSize: r.fs(16)),
                            ),
                            SizedBox(height: r.sp(8)),
                            Text(
                              'Tap the heart on any coffee to save it here.',
                              style: AppTextStyles.bodySmall
                                  .copyWith(fontSize: r.fs(13)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(r.pagePadH),
                        itemCount: liked.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: r.sp(12)),
                        itemBuilder: (_, i) {
                          final coffee = liked[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.cream.withOpacity(0.92),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryBrown
                                      .withOpacity(0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(r.sp(12)),
                              child: Row(
                                children: [
                                  // Thumbnail
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      width: r.sp(72),
                                      height: r.sp(72),
                                      child: Image.asset(
                                        coffee.imageAsset,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            Container(
                                          color: AppColors.mediumBrown,
                                          child: Center(
                                            child: Text('☕',
                                                style: TextStyle(
                                                    fontSize: r.fs(28))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: r.sp(12)),

                                  // Name / description / price
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(coffee.name,
                                            style: AppTextStyles.titleSmall
                                                .copyWith(
                                                    fontSize: r.fs(14))),
                                        SizedBox(height: r.sp(4)),
                                        Text(
                                          coffee.description,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(fontSize: r.fs(12)),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: r.sp(8)),
                                        Text(
                                          coffee.price.asPrice,
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(
                                            color: AppColors.primaryBrown,
                                            fontWeight: FontWeight.w700,
                                            fontSize: r.fs(14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Heart + Add buttons
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => ref
                                            .read(coffeeProvider.notifier)
                                            .toggleLike(coffee.id),
                                        child: Icon(
                                          CupertinoIcons.heart_fill,
                                          color: const Color(0xFFFF375F),
                                          size: r.fs(22),
                                        ),
                                      ),
                                      SizedBox(height: r.sp(12)),
                                      GestureDetector(
                                        onTap: () => ref
                                            .read(cartProvider.notifier)
                                            .addItem(coffee),
                                        child: Container(
                                          width: r.sp(32),
                                          height: r.sp(32),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primaryBrown,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: AppColors.textOnDark,
                                            size: r.fs(16),
                                          ),
                                        ),
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
            ),
          ),
        ],
      ),
    );
  }
}