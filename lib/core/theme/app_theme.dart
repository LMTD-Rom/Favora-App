import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';

/// Favora Design System - Theme Configuration
///
/// Provides complete ThemeData for the app with a premium,
/// modern fintech-inspired aesthetic.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'PlusJakartaSans',

      // --- Color Scheme --------------------------------------
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.textOnPrimary,
        primaryContainer: AppColors.primarySoft,
        secondary: AppColors.accent,
        onSecondary: AppColors.textOnAccent,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
        outline: AppColors.border,
      ),

      // --- Scaffold ------------------------------------------
      scaffoldBackgroundColor: AppColors.background,

      // --- AppBar --------------------------------------------
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: AppTypography.headingMedium,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),

      // --- Card ----------------------------------------------
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
        margin: EdgeInsets.zero,
      ),

      // --- Elevated Button -----------------------------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusFull,
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // --- Outlined Button -----------------------------------
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusFull,
          ),
          side: const BorderSide(color: AppColors.border),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // --- Text Button ---------------------------------------
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // --- Input Decoration ----------------------------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
        labelStyle: AppTypography.labelLarge,
        errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.error),
      ),

      // --- Bottom Navigation ---------------------------------
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      ),

      // --- Chip ----------------------------------------------
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTypography.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        side: BorderSide.none,
      ),

      // --- Divider -------------------------------------------
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 0,
      ),

      // --- SnackBar ------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryDark,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textOnPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // --- Dialog --------------------------------------------
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusXl,
        ),
        titleTextStyle: AppTypography.headingSmall,
        contentTextStyle: AppTypography.bodyMedium,
      ),

      // --- Bottom Sheet --------------------------------------
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.border,
      ),

      // --- Tab Bar -------------------------------------------
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryLight,
        unselectedLabelColor: AppColors.textTertiary,
        labelStyle: AppTypography.titleMedium,
        unselectedLabelStyle: AppTypography.bodyMedium,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(
            color: AppColors.primaryLight,
            width: 2.5,
          ),
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}
