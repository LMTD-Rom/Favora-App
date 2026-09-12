import 'package:flutter/material.dart';

/// Favora Design System - Spacing & Radius
///
/// Consistent 4px base unit spacing scale.
/// Generous padding for a premium, breathable feel.
class AppSpacing {
  AppSpacing._();

  // --- Spacing Scale (4px base) -------------------------------
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 48;
  static const double giant = 64;

  // --- Screen Padding -----------------------------------------
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 24,
  );

  // --- Card Padding -------------------------------------------
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  static const EdgeInsets cardPaddingCompact = EdgeInsets.all(16);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(24);

  // --- Border Radius ------------------------------------------
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusXxl = 24;
  static const double radiusFull = 999;

  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderRadiusXxl = BorderRadius.circular(radiusXxl);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(radiusFull);

  // --- Section Gaps -------------------------------------------
  static const double sectionGap = 24;
  static const double listItemGap = 12;
  static const double inlineGap = 8;

  // --- Bottom Nav Height --------------------------------------
  static const double bottomNavHeight = 80;
  static const double bottomNavSafeArea = 100;
}
