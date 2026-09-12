import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/constants/app_constants.dart';

/// Splash screen with animated Favora logo.
class SplashScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const SplashScreen({super.key, required this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), widget.onFinished);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Stack(
          children: [
            // Background circles
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.glassOverlay,
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.glassOverlay,
                ),
              ),
            ),
            // Logo & text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.glassWhite,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.glassBorder, width: 1),
                    ),
                    child: const Icon(
                      Icons.card_membership_rounded,
                      size: 52,
                      color: Colors.white,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic)
                      .scale(
                        begin: const Offset(0.6, 0.6),
                        end: const Offset(1, 1),
                        duration: 800.ms,
                        curve: Curves.easeOutBack,
                      ),
                  const SizedBox(height: 24),
                  // Brand name
                  Text(
                    AppConstants.appName,
                    style: AppTypography.displayLarge.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                      letterSpacing: -1.5,
                    ),
                  )
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
                  const SizedBox(height: 8),
                  // Tagline
                  Text(
                    AppConstants.appTaglineId,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 0.5,
                    ),
                  )
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 600.ms),
                ],
              ),
            ),
            // Loading indicator
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              )
                  .animate(delay: 800.ms)
                  .fadeIn(duration: 400.ms),
            ),
          ],
        ),
      ),
    );
  }
}

