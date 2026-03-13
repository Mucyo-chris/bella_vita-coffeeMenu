// lib/presentation/providers/theme_provider.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, Brightness>(
  (_) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<Brightness> {
  ThemeNotifier() : super(Brightness.light);

  bool get isDark => state == Brightness.dark;

  void toggle() {
    state = isDark ? Brightness.light : Brightness.dark;
  }

  void setDark(bool value) {
    state = value ? Brightness.dark : Brightness.light;
  }
}
