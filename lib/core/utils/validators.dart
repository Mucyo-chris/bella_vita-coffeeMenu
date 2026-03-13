import '../constants/app_strings.dart';

/// Pure validation helpers — no Flutter dependency.
abstract final class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }

  static String? email(String? value) {
    final req = required(value);
    if (req != null) return req;
    final isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!.trim());
    if (!isValid) return AppStrings.invalidEmail;
    return null;
  }

  static String? password(String? value) {
    final req = required(value);
    if (req != null) return req;
    if (value!.length < 6) return AppStrings.passwordMinLen;
    return null;
  }

  static String? Function(String?) confirmPassword(String original) {
    return (String? value) {
      final req = required(value);
      if (req != null) return req;
      if (value != original) return AppStrings.passwordMismatch;
      return null;
    };
  }

  static String? username(String? value) {
    final req = required(value);
    if (req != null) return req;
    if (value!.trim().length < 3) return 'Username must be at least 3 characters';
    return null;
  }
}
