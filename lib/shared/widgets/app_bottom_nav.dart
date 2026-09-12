import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/core/theme/app_typography.dart';

/// Premium bottom navigation bar with center FAB for QR scan.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: Icons.card_giftcard_rounded,
            label: 'Rewards',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          // Center QR FAB spacer
          _QrCenterButton(
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _NavItem(
            icon: Icons.receipt_long_rounded,
            label: 'Riwayat',
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
          _NavItem(
            icon: Icons.person_rounded,
            label: 'Profil',
            isSelected: currentIndex == 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryLight.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: AppSpacing.borderRadiusFull,
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected
                    ? AppColors.primaryLight
                    : AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected
                    ? AppColors.primaryLight
                    : AppColors.textTertiary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrCenterButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _QrCenterButton({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryLight.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.qr_code_2_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}

