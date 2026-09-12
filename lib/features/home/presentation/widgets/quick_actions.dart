import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';

/// Quick action grid: QR, Rewards, Riwayat, Promo.
class QuickActions extends StatelessWidget {
  final VoidCallback onQrTap;
  final VoidCallback onRewardsTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onPromoTap;

  const QuickActions({
    super.key,
    required this.onQrTap,
    required this.onRewardsTap,
    required this.onHistoryTap,
    required this.onPromoTap,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionItem(
        icon: Icons.qr_code_2_rounded,
        label: 'QR Saya',
        color: AppColors.primaryLight,
        bgColor: AppColors.primaryLight.withOpacity(0.1),
        onTap: onQrTap,
      ),
      _ActionItem(
        icon: Icons.card_giftcard_rounded,
        label: 'Rewards',
        color: AppColors.accent,
        bgColor: AppColors.accent.withOpacity(0.1),
        onTap: onRewardsTap,
      ),
      _ActionItem(
        icon: Icons.receipt_long_rounded,
        label: 'Riwayat',
        color: AppColors.warning,
        bgColor: AppColors.warning.withOpacity(0.1),
        onTap: onHistoryTap,
      ),
      _ActionItem(
        icon: Icons.local_offer_rounded,
        label: 'Promo',
        color: AppColors.promoTag,
        bgColor: AppColors.promoTag.withOpacity(0.1),
        onTap: onPromoTap,
      ),
    ];

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: AppColors.cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((action) {
          return GestureDetector(
            onTap: action.onTap,
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: action.bgColor,
                    borderRadius: AppSpacing.borderRadiusMd,
                  ),
                  child: Icon(action.icon, color: action.color, size: 26),
                ),
                const SizedBox(height: 8),
                Text(
                  action.label,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.onTap,
  });
}

