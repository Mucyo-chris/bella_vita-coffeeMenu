import 'dart:ui';

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
import '../../widgets/common/app_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final isDark = ref.watch(themeProvider) == Brightness.dark;
    final user = authState.user;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.cream,
      child: Stack(
        children: [

          /// Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/beans.png",
              fit: BoxFit.cover,
            ),
          ),

          /// Blur Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0,
                sigmaY: 0,
              ),
              child: Container(
                color: AppColors.cream.withOpacity(0.85),
              ),
            ),
          ),

          /// Page Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.sp24),

                  /// Avatar
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBrown,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBrown.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.person_fill,
                      color: AppColors.textOnDark,
                      size: 44,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.sp16),

                  Text(
                    user?.username ?? 'Guest',
                    style: AppTextStyles.titleLarge,
                  ),

                  const SizedBox(height: AppDimensions.sp4),

                  Text(
                    user?.email ?? 'Not signed in',
                    style: AppTextStyles.bodySmall,
                  ),

                  const SizedBox(height: AppDimensions.sp32),

                  /// Preferences Section
                  _Section(
                    title: 'Preferences',
                    children: [
                      _SettingRow(
                        icon: CupertinoIcons.moon,
                        label: AppStrings.darkMode,
                        trailing: CupertinoSwitch(
                          value: isDark,
                          onChanged: (_) =>
                              ref.read(themeProvider.notifier).toggle(),
                          activeColor: AppColors.primaryBrown,
                        ),
                      ),
                      _SettingRow(
                        icon: CupertinoIcons.bell,
                        label: 'Push Notifications',
                        trailing: CupertinoSwitch(
                          value: true,
                          onChanged: (_) {},
                          activeColor: AppColors.primaryBrown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.sp20),

                  /// Account Section
                  _Section(
                    title: 'Account',
                    children: [
                      _SettingRow(
                        icon: CupertinoIcons.creditcard,
                        label: AppStrings.payment,
                        onTap: () {},
                      ),
                      _SettingRow(
                        icon: CupertinoIcons.star,
                        label: 'My Orders',
                        onTap: () {},
                      ),
                      _SettingRow(
                        icon: CupertinoIcons.question_circle,
                        label: AppStrings.help,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.sp32),

                  /// Logout Button
                  AppButton(
                    label: AppStrings.logOut,
                    style: AppButtonStyle.outlined,
                    onTap: () {
                      ref.read(authProvider.notifier).logout();
                      context.go(AppRoutes.login);
                    },
                  ),

                  const SizedBox(height: AppDimensions.sp24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.sp4,
            bottom: AppDimensions.sp8,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyles.label.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.beige,
            borderRadius: BorderRadius.circular(AppDimensions.radius16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.sp16,
          vertical: AppDimensions.sp14,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryBrown,
              size: AppDimensions.iconSize,
            ),
            const SizedBox(width: AppDimensions.sp12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyMedium,
              ),
            ),
            trailing ??
                const Icon(
                  CupertinoIcons.chevron_forward,
                  color: AppColors.textTertiary,
                  size: 16,
                ),
          ],
        ),
      ),
    );
  }
}