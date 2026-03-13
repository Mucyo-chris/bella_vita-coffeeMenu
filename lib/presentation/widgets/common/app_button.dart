import 'package:flutter/cupertino.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';

enum AppButtonStyle { filled, outlined, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isLoading;
  final AppButtonStyle style;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leading;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.style = AppButtonStyle.filled,
    this.width,
    this.height = 50.0,
    this.backgroundColor,
    this.textColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ??
        (style == AppButtonStyle.filled
            ? AppColors.primaryBrown
            : CupertinoColors.transparent);

    final fg = textColor ??
        (style == AppButtonStyle.filled
            ? AppColors.textOnDark
            : AppColors.primaryBrown);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          border: style == AppButtonStyle.outlined
              ? Border.all(color: AppColors.primaryBrown, width: 1.5)
              : null,
          boxShadow: style == AppButtonStyle.filled && onTap != null
              ? [
                  BoxShadow(
                    color: AppColors.primaryBrown.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: isLoading
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.textOnDark,
                  radius: 10,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: AppDimensions.sp8),
                  ],
                  Text(
                    label,
                    style: AppTextStyles.buttonLarge.copyWith(color: fg),
                  ),
                ],
              ),
      ),
    );
  }
}