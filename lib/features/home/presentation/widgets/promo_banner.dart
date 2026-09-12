import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/features/history/domain/transaction_model.dart';

/// Horizontal promo banner carousel.
class PromoBanner extends StatefulWidget {
  final List<PromoModel> promos;

  const PromoBanner({super.key, required this.promos});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _controller = PageController(viewportFraction: 0.88);
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Promo Untukmu', style: AppTypography.titleLarge),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemCount: widget.promos.length,
            itemBuilder: (context, index) {
              final promo = widget.promos[index];
              final colors = promo.gradientColors.map((c) {
                return Color(int.parse(c.replaceFirst('#', '0xFF')));
              }).toList();

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: AppSpacing.borderRadiusLg,
                    boxShadow: [
                      BoxShadow(
                        color: colors.first.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Promo tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          'PROMO',
                          style: AppTypography.tag.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        promo.title,
                        style: AppTypography.headingSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        promo.subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Dots
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.promos.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentIndex == index ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.primaryLight
                    : AppColors.border,
                borderRadius: AppSpacing.borderRadiusFull,
              ),
            );
          }),
        ),
      ],
    );
  }
}


