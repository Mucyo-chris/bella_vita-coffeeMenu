import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

class AppSideMenu extends ConsumerWidget {
  final VoidCallback onClose;
  const AppSideMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == Brightness.dark;
    final bg = isDark ? AppColors.darkSurface : AppColors.primaryBrown;

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.78,
        height: double.infinity,
        color: bg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.sp24,
                AppDimensions.sp32,
                AppDimensions.sp16,
                AppDimensions.sp8,
              ),
              child: Row(
                children: [
                  Text(
                    AppStrings.appName,
                    style: AppTextStyles.brandItalic.copyWith(
                      color: AppColors.textOnDark, fontSize: 28,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onClose,
                    child: const Icon(CupertinoIcons.xmark,
                        color: AppColors.textOnDark, size: 22),
                  ),
                ],
              ),
            ),
            _divider(),
            const SizedBox(height: AppDimensions.sp16),

            _MenuItem(
              icon: CupertinoIcons.bell,
              label: AppStrings.notification,
              onTap: () {
                onClose();
                context.push(AppRoutes.notification);
              },
            ),

            // Dark mode toggle
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.sp24,
                vertical: AppDimensions.sp4,
              ),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.moon,
                      color: AppColors.textOnDark, size: AppDimensions.iconSize),
                  SizedBox(width: AppDimensions.sp14),
                  Text(
                    AppStrings.darkMode,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textOnDark, fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  CupertinoSwitch(
                    value: isDark,
                    onChanged: (_) => ref.read(themeProvider.notifier).toggle(),
                    activeColor: AppColors.lightBrown,
                    trackColor: AppColors.textOnDark.withOpacity(0.3),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.sp8),
            _divider(),
            SizedBox(height: AppDimensions.sp8),

            _MenuItem(icon: CupertinoIcons.person, label: AppStrings.profile, onTap: onClose),
            _MenuItem(icon: CupertinoIcons.cart, label: AppStrings.myCart, onTap: onClose),
            _MenuItem(icon: CupertinoIcons.creditcard, label: AppStrings.payment, onTap: onClose),
            _MenuItem(icon: CupertinoIcons.settings, label: AppStrings.settings, onTap: onClose),
            _MenuItem(icon: CupertinoIcons.question_circle, label: AppStrings.help, onTap: onClose),

            const Spacer(),
            _divider(),

            _MenuItem(
              icon: CupertinoIcons.square_arrow_left,
              label: AppStrings.logOut,
              onTap: () {
                onClose();
                ref.read(authProvider.notifier).logout();
                context.go(AppRoutes.login);
              },
            ),
            const SizedBox(height: AppDimensions.sp24),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
        height: 1,
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.sp24),
        color: AppColors.textOnDark.withOpacity(0.15),
      );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.sp24,
          vertical: AppDimensions.sp12,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textOnDark, size: AppDimensions.iconSize),
            SizedBox(width: AppDimensions.sp14),
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textOnDark, fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}