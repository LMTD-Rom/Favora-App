import 'package:flutter/material.dart';

/// Favora Design System - Color Palette
///
/// Premium navy-blue gradient aesthetic inspired by modern fintech apps.
/// Tier colors for Bronze / Silver / Gold membership levels.
class AppColors {
  AppColors._();

  // --- Primary Gradient ----------------------------------------
  static const Color primaryDark = Color(0xFF0A1B3D);
  static const Color primary = Color(0xFF1E3A5F);
  static const Color primaryLight = Color(0xFF2563EB);
  static const Color primarySoft = Color(0xFF3B82F6);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, Color(0xFF1E40AF)],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, primary, Color(0xFF1E40AF)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A5F), Color(0xFF2563EB)],
  );

  // --- Accent Colors ------------------------------------------
  static const Color accent = Color(0xFF10B981);       // Emerald - success, poin masuk
  static const Color accentSoft = Color(0xFF34D399);
  static const Color warning = Color(0xFFF59E0B);      // Amber - notifikasi, peringatan
  static const Color error = Color(0xFFEF4444);         // Red - error states
  static const Color info = Color(0xFF06B6D4);          // Cyan - info badges

  // --- Tier Colors ---------------------------------------------
  static const Color tierBronze = Color(0xFFCD7F32);
  static const Color tierBronzeLight = Color(0xFFF5E6D0);
  static const Color tierSilver = Color(0xFF9CA3AF);
  static const Color tierSilverLight = Color(0xFFE5E7EB);
  static const Color tierGold = Color(0xFFFFD700);
  static const Color tierGoldLight = Color(0xFFFFF9DB);

  static const LinearGradient bronzeGradient = LinearGradient(
    colors: [Color(0xFFCD7F32), Color(0xFFE8A854)],
  );
  static const LinearGradient silverGradient = LinearGradient(
    colors: [Color(0xFF9CA3AF), Color(0xFFD1D5DB)],
  );
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFC107), Color(0xFFFFE082)],
  );

  // --- Surface & Background -----------------------------------
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color cardSurface = Color(0xFFFFFFFF);

  // --- Glass / Frosted ----------------------------------------
  static const Color glassWhite = Color(0x33FFFFFF);    // 20% white
  static const Color glassBorder = Color(0x1AFFFFFF);   // 10% white
  static const Color glassOverlay = Color(0x0DFFFFFF);  // 5% white
  static const Color glassDark = Color(0x33000000);     // 20% black

  // --- Text Colors ---------------------------------------------
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFFFFFFFF);

  // --- Border & Divider ---------------------------------------
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);

  // --- Semantic Colors ----------------------------------------
  static const Color pointsIn = Color(0xFF10B981);      // Poin masuk - hijau
  static const Color pointsOut = Color(0xFFEF4444);     // Poin keluar - merah
  static const Color promoTag = Color(0xFFEC4899);      // Pink - promo badge

  // --- Shadows ------------------------------------------------
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primaryDark.withOpacity(0.06),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: primaryDark.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: primaryDark.withOpacity(0.12),
      blurRadius: 32,
      offset: const Offset(0, 12),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: primaryDark.withOpacity(0.03),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}
