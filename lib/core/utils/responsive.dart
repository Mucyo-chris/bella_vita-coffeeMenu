import 'package:flutter/cupertino.dart';

/// Device size breakpoints
enum DeviceType { phone, tablet, desktop }

class Responsive {
  final BuildContext _ctx;
  late final double _w;
  late final double _h;
  late final double _sp; // shortest side

  Responsive(this._ctx) {
    final size = MediaQuery.sizeOf(_ctx);
    _w  = size.width;
    _h  = size.height;
    _sp = size.shortestSide;
  }

  // ── Device classification ─────────────────────────────────
  DeviceType get deviceType {
    if (_sp >= 900) return DeviceType.desktop;
    if (_sp >= 600) return DeviceType.tablet;
    return DeviceType.phone;
  }

  bool get isPhone   => deviceType == DeviceType.phone;
  bool get isTablet  => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  // ── Raw dimensions ────────────────────────────────────────
  double get width  => _w;
  double get height => _h;
  double get shortestSide => _sp;

  // ── Fluid font scale ──────────────────────────────────────
  /// Scale a base font size relative to 375pt (iPhone SE/14)
  double fs(double base) {
    final scale = (_sp / 375).clamp(0.85, 1.6);
    return base * scale;
  }

  // ── Fluid spacing ─────────────────────────────────────────
  /// Scale a base spacing value
  double sp(double base) {
    final scale = (_sp / 375).clamp(0.85, 1.8);
    return base * scale;
  }

  // ── Layout helpers ────────────────────────────────────────
  /// Horizontal page padding
  double get pagePadH {
    if (isDesktop) return _w * 0.2;
    if (isTablet)  return _w * 0.08;
    return 20.0;
  }

  /// Max content width (for tablet/desktop centering)
  double get maxContentWidth {
    if (isDesktop) return 560;
    if (isTablet)  return 640;
    return double.infinity;
  }

  /// Grid column count for coffee cards
  int get coffeeGridColumns {
    if (isDesktop) return 4;
    if (isTablet)  return 3;
    return 2;
  }

  /// Coffee card aspect ratio
  double get coffeeCardRatio {
    if (isTablet || isDesktop) return 0.72;
    return 0.68;
  }

  /// Button height
  double get buttonHeight {
    if (isTablet || isDesktop) return 58;
    return 50;
  }

  /// App logo size
  double get logoSize {
    if (isDesktop) return 120;
    if (isTablet)  return 100;
    return 80;
  }

  /// Payment logo box size
  double get payLogoSize {
    if (isDesktop) return 200;
    if (isTablet)  return 160;
    return 120;
  }

  /// Avatar / profile image size
  double get avatarSize {
    if (isDesktop) return 120;
    if (isTablet)  return 100;
    return 80;
  }

  /// Category chip height
  double get chipHeight {
    if (isTablet || isDesktop) return 44;
    return 36;
  }

  /// Side menu width fraction
  double get sideMenuWidth {
    if (isDesktop) return _w * 0.28;
    if (isTablet)  return _w * 0.45;
    return _w * 0.78;
  }

  // ── Convenience picker ────────────────────────────────────
  T pick<T>({required T phone, required T tablet, T? desktop}) {
    if (isDesktop) return desktop ?? tablet;
    if (isTablet)  return tablet;
    return phone;
  }
}

/// Extension for easy access
extension ResponsiveContext on BuildContext {
  Responsive get r => Responsive(this);
}