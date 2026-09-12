import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';

/// Scaffold wrapper with gradient background.
///
/// Provides the premium navy -> blue gradient header
/// that scrolls naturally with content.
class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBodyBehindAppBar;
  final double gradientHeight;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.extendBodyBehindAppBar = true,
    this.gradientHeight = 320,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              AppColors.background,
              AppColors.background,
            ],
            stops: [0.0, 0.15, 0.35, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Subtle circle decorations (scroll with content)
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.glassOverlay,
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: -60,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.glassOverlay,
                ),
              ),
            ),
            // Body content
            body,
          ],
        ),
      ),
    );
  }
}
