import 'package:flutter/cupertino.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(right: AppDimensions.sp8),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.sp16,
          vertical: AppDimensions.sp8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBrown
              : AppColors.beige,
          borderRadius:
              BorderRadius.circular(AppDimensions.radiusFull),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryBrown.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.titleSmall.copyWith(
            color: isSelected
                ? AppColors.textOnDark
                : AppColors.mediumBrown,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}