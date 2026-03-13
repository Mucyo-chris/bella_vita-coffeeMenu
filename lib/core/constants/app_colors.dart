import 'package:flutter/cupertino.dart';

/// All brand + semantic colours for Bella Vita.
abstract final class AppColors {
  // ── Brand ─────────────────────────────────────────────────
  static const Color primaryBrown   = Color(0xFF3E1A00);
  static const Color darkBrown      = Color(0xFF2C1200);
  static const Color mediumBrown    = Color(0xFF7B4F2E);
  static const Color lightBrown     = Color(0xFFD4A57A);
  static const Color accentGold     = Color(0xFFB8864E);

  // ── Background / Surface ──────────────────────────────────
  static const Color cream          = Color(0xFFF5E6D3);
  static const Color beige          = Color(0xFFEDD9C0);
  static const Color cardSurface    = Color(0xFFE8D5BB);
  static const Color inputFill      = Color(0xFFF0E4D0);

  // ── iOS System ────────────────────────────────────────────
  static const Color iosBackground  = Color(0xFFF2F2F7);
  static const Color iosGrouped     = Color(0xFFFFFFFF);
  static const Color iosSeparator   = Color(0xFFD1D1D6);
  static const Color iosLabel       = Color(0xFF1C1C1E);
  static const Color iosSecondary   = Color(0xFF6E6E73);

  // ── Dark Mode ─────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF1A0D00);
  static const Color darkSurface    = Color(0xFF2C1800);
  static const Color darkCard       = Color(0xFF3A2010);

  // ── Semantic ──────────────────────────────────────────────
  static const Color success        = Color(0xFF34C759);
  static const Color warning        = Color(0xFFFF9500);
  static const Color error          = Color(0xFFFF3B30);
  static const Color info           = Color(0xFF007AFF);

  // ── Text ──────────────────────────────────────────────────
  static const Color textPrimary    = Color(0xFF1C1C1E);
  static const Color textSecondary  = Color(0xFF6E6E73);
  static const Color textTertiary   = Color(0xFFAEAEB2);
  static const Color textOnDark     = Color(0xFFFFFFFF);
  static const Color textOnBrown    = Color(0xFFFFFFFF);
}
