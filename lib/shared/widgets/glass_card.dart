import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_spacing.dart';

/// Premium glassmorphism card with frosted glass effect.
///
/// Used throughout the app for elevated content containers.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double blur;
  final Border? border;
  final List<BoxShadow>? shadows;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.blur = 12,
    this.border,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? AppSpacing.borderRadiusXl,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.glassWhite,
            borderRadius: borderRadius ?? AppSpacing.borderRadiusXl,
            border: border ??
                Border.all(
                  color: AppColors.glassBorder,
                  width: 1,
                ),
            boxShadow: shadows,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Solid white card with subtle shadow " for light backgrounds.
class SolidCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Color? color;

  const SolidCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColors.cardSurface,
      borderRadius: borderRadius ?? AppSpacing.borderRadiusLg,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? AppSpacing.borderRadiusLg,
        child: Container(
          padding: padding ?? AppSpacing.cardPadding,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? AppSpacing.borderRadiusLg,
            boxShadow: AppColors.cardShadow,
          ),
          child: child,
        ),
      ),
    );
  }
}

