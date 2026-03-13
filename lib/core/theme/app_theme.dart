import 'package:flutter/cupertino.dart';
import '../constants/app_colors.dart';

/// Cupertino-first theme configuration for Bella Vita.
abstract final class AppTheme {
  // ── Light ─────────────────────────────────────────────────
  static const CupertinoThemeData light = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBrown,
    primaryContrastingColor: AppColors.textOnDark,
    scaffoldBackgroundColor: AppColors.cream,
    barBackgroundColor: AppColors.cream,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.primaryBrown,
      textStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        color: AppColors.textPrimary,
        fontSize: 17,
        decoration: TextDecoration.none,
      ),
      navTitleTextStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        color: AppColors.primaryBrown,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      ),
      navLargeTitleTextStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        color: AppColors.primaryBrown,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ),
      tabLabelTextStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
    ),
  );

  // ── Dark ──────────────────────────────────────────────────
  static const CupertinoThemeData dark = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.lightBrown,
    primaryContrastingColor: AppColors.textOnDark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    barBackgroundColor: AppColors.darkBackground,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.lightBrown,
      textStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        color: AppColors.textOnDark,
        fontSize: 17,
        decoration: TextDecoration.none,
      ),
      navTitleTextStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        color: AppColors.textOnDark,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      ),
      navLargeTitleTextStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        color: AppColors.textOnDark,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ),
      tabLabelTextStyle: TextStyle(
        fontFamily: '.SF Pro Display',
        fontSize: 10,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
