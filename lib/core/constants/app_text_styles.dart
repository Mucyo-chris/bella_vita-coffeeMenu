import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

/// San Francisco–inspired typography scale.
abstract final class AppTextStyles {
  // ── Display ───────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.37,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.36,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  // ── Title ─────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.35,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.23,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  // ── Body ──────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.41,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.23,
    color: AppColors.textPrimary,
    decoration: TextDecoration.none,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.08,
    color: AppColors.textSecondary,
    decoration: TextDecoration.none,
  );

  // ── Caption ───────────────────────────────────────────────
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.textTertiary,
    decoration: TextDecoration.none,
  );

  // ── Label ─────────────────────────────────────────────────
  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.07,
    color: AppColors.textSecondary,
    decoration: TextDecoration.none,
  );

  // ── Button ────────────────────────────────────────────────
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    color: AppColors.textOnDark,
    decoration: TextDecoration.none,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.23,
    color: AppColors.textOnDark,
    decoration: TextDecoration.none,
  );

  // ── Italic helpers ────────────────────────────────────────
  static const TextStyle brandItalic = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.5,
    color: AppColors.primaryBrown,
    decoration: TextDecoration.none,
  );
}
