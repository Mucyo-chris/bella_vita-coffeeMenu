import 'package:flutter/cupertino.dart';
import '../constants/app_colors.dart';

extension ContextX on BuildContext {
  bool get isDark =>
      CupertinoTheme.of(this).brightness == Brightness.dark;

  Color get backgroundColor => isDark
      ? AppColors.darkBackground
      : AppColors.cream;

  Color get cardColor => isDark
      ? AppColors.darkCard
      : AppColors.cardSurface;

  Color get textPrimary => isDark
      ? AppColors.textOnDark
      : AppColors.textPrimary;

  Color get textSecondary => isDark
      ? AppColors.textOnDark.withOpacity(0.7)
      : AppColors.textSecondary;
}

extension StringX on String {
  bool get isValidEmail =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(this);

  String get capitalise =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ').map((w) => w.capitalise).join(' ');
}

extension DoubleX on double {
  /// Format as price string, e.g. 3.5 → "\$3.50"
  String get asPrice => '\$${toStringAsFixed(2)}';
}

extension IntX on int {
  /// Badge count capped at 99+
  String get badgeLabel => this > 99 ? '99+' : toString();
}
