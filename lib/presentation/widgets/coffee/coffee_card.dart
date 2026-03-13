import 'package:flutter/cupertino.dart';
import '../../../domain/entities/coffee_entity.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeEntity coffee;
  final VoidCallback onLikeToggle;
  final VoidCallback onAddToCart;

  const CoffeeCard({
    super.key,
    required this.coffee,
    required this.onLikeToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.coffeeCardWidth,
      height: AppDimensions.coffeeCardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radius20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBrown.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radius20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.asset(
              coffee.imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6B3A2A), Color(0xFF3E1A00)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text('☕', style: TextStyle(fontSize: 52)),
                ),
              ),
            ),

            // Dark gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CupertinoColors.transparent,
                      AppColors.darkBrown.withOpacity(0.75),
                    ],
                    stops: const [0.45, 1.0],
                  ),
                ),
              ),
            ),

            // Like button
            Positioned(
              top: AppDimensions.sp10,
              right: AppDimensions.sp10,
              child: GestureDetector(
                onTap: onLikeToggle,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.textOnDark.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    coffee.isLiked
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: coffee.isLiked
                        ? const Color(0xFFFF375F)
                        : AppColors.textOnDark,
                    size: 18,
                  ),
                ),
              ),
            ),

            // Bottom info
            Positioned(
              bottom: AppDimensions.sp10,
              left: AppDimensions.sp10,
              right: AppDimensions.sp10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          coffee.name,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textOnDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: AppDimensions.sp2),
                        Text(
                          coffee.price.asPrice,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.lightBrown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: AppDimensions.sp8),
                  GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBrown,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.lightBrown, width: 1),
                      ),
                      child: Icon(
                        CupertinoIcons.add,
                        color: AppColors.textOnDark,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Rating badge
            Positioned(
              top: AppDimensions.sp10,
              left: AppDimensions.sp10,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.sp6,
                    vertical: AppDimensions.sp2),
                decoration: BoxDecoration(
                  color: AppColors.textOnDark.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radius8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.star_fill,
                      color: Color(0xFFFFCC00),
                      size: 11,
                    ),
                    SizedBox(width: AppDimensions.sp2),
                    Text(
                      coffee.rating.toStringAsFixed(1),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textOnDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}