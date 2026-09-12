import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/features/auth/domain/user_model.dart';

/// Points summary with tier progress bar.
class PointsSummary extends StatelessWidget {
  final UserModel user;

  const PointsSummary({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final nextTier = user.tier.nextTier;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress Tier', style: AppTypography.titleMedium),
              if (nextTier != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: nextTier.lightColor,
                    borderRadius: AppSpacing.borderRadiusFull,
                  ),
                  child: Text(
                    '${user.pointsToNextTier} poin lagi',
                    style: AppTypography.tag.copyWith(
                      color: nextTier.color,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          Row(
            children: [
              // Current tier icon
              Icon(user.tier.icon, color: user.tier.color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: AppSpacing.borderRadiusFull,
                      child: LinearProgressIndicator(
                        value: user.tierProgress,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(user.tier.color),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.tier.displayName,
                          style: AppTypography.labelSmall.copyWith(
                            color: user.tier.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (nextTier != null)
                          Text(
                            nextTier.displayName,
                            style: AppTypography.labelSmall.copyWith(
                              color: nextTier.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (nextTier != null)
                Icon(nextTier.icon, color: nextTier.color, size: 20),
            ],
          ),
          // Multiplier info
          if (user.tier.multiplier > 1) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded, size: 14, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(
                    'Bonus ${user.tier.multiplier}x poin setiap transaksi',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}


