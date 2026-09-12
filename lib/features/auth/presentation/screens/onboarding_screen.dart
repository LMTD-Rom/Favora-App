import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';

/// Onboarding with 3 pages explaining app features.
class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      icon: Icons.qr_code_2_rounded,
      title: 'Kartu Member Digital',
 subtitle: 'QR code unik sebagai identitas membermu. Cukup tunjukkan saat belanja " tanpa kartu fisik!',
      gradient: [Color(0xFF2563EB), Color(0xFF3B82F6)],
    ),
    _OnboardingPage(
      icon: Icons.stars_rounded,
      title: 'Kumpulkan Poin',
      subtitle: 'Setiap transaksi menambah poin. Naik level dari Bronze ke Silver, lalu Gold dengan bonus berlipat!',
      gradient: [Color(0xFF059669), Color(0xFF10B981)],
    ),
    _OnboardingPage(
      icon: Icons.card_giftcard_rounded,
      title: 'Tukar dengan Hadiah',
      subtitle: 'Tukar poinmu dengan voucher diskon, menu gratis, dan hadiah spesial lainnya.',
      gradient: [Color(0xFFDB2777), Color(0xFFEC4899)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.onComplete,
                child: Text(
                  'Lewati',
                  style: AppTypography.buttonMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon in gradient circle
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: page.gradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: page.gradient.first.withOpacity(0.3),
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Icon(
                            page.icon,
                            size: 64,
                            color: Colors.white,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1, 1),
                              duration: 600.ms,
                              curve: Curves.easeOutBack,
                            ),
                        const SizedBox(height: 48),
                        Text(
                          page.title,
                          style: AppTypography.headingLarge,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
                        const SizedBox(height: 16),
                        Text(
                          page.subtitle,
                          style: AppTypography.bodyLarge,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 350.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bottom section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                children: [
                  // Dot indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      expansionFactor: 3,
                      spacing: 6,
                      activeDotColor: AppColors.primaryLight,
                      dotColor: AppColors.border,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Mulai Sekarang'
                            : 'Lanjut',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });
}

