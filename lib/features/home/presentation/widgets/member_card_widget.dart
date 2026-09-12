import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/core/utils/formatters.dart';
import 'package:favora_app/features/auth/domain/user_model.dart';

/// Floating member card showing QR code, tier badge, points.
/// - Tap the expand icon to open full QR screen.
/// - Tap the bottom member info area to flip and reveal details.
class MemberCardWidget extends StatefulWidget {
  final UserModel user;
  final VoidCallback onQrTap;

  const MemberCardWidget({
    super.key,
    required this.user,
    required this.onQrTap,
  });

  @override
  State<MemberCardWidget> createState() => _MemberCardWidgetState();
}

class _MemberCardWidgetState extends State<MemberCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isFlipped = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    HapticFeedback.lightImpact();
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: AppSpacing.borderRadiusXl,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: tier badge + brand
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tier badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: user.tier.gradient,
                  borderRadius: AppSpacing.borderRadiusFull,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(user.tier.icon, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      user.tier.displayName,
                      style: AppTypography.tag.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              // Brand
              Text(
                'FAVORA',
                style: AppTypography.eyebrow.copyWith(
                  color: Colors.white.withOpacity(0.6),
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Center: QR + points + expand button
          Row(
            children: [
              // Mini QR (non-tappable, just display)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: QrImageView(
                  data: 'FAVORA:${user.memberId}:${DateTime.now().millisecondsSinceEpoch}',
                  version: QrVersions.auto,
                  size: 64,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: AppColors.primaryDark,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Points info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Poin Tersedia',
                      style: AppTypography.labelMedium.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppFormatters.number(user.availablePoints),
                      style: AppTypography.pointsLarge,
                    ),
                  ],
                ),
              ),
              // Expand QR button - ONLY this opens QR screen
              GestureDetector(
                onTap: widget.onQrTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.glassWhite,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fullscreen_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom: Flippable member info area
          GestureDetector(
            onTap: _toggleFlip,
            child: AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                final angle = _flipAnimation.value * pi;
                final isFrontVisible = angle < pi / 2;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspective
                    ..rotateX(angle),
                  child: isFrontVisible
                      ? _buildFrontSide(user)
                      : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateX(pi),
                          child: _buildBackSide(user),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Front side: Name + Member ID
  Widget _buildFrontSide(UserModel user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.glassOverlay,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MEMBER',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white.withOpacity(0.5),
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                user.name,
                style: AppTypography.titleMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            AppFormatters.memberId(user.memberId),
            style: AppTypography.labelMedium.copyWith(
              color: Colors.white.withOpacity(0.7),
              fontFamily: 'monospace',
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.touch_app_rounded,
            color: Colors.white.withOpacity(0.4),
            size: 16,
          ),
        ],
      ),
    );
  }

  // Back side: Member details
  Widget _buildBackSide(UserModel user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.08),
          ],
        ),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        children: [
          // Member since
          _detailChip(Icons.calendar_today_rounded, 'Sejak ${_memberSince(user)}'),
          const SizedBox(width: 8),
          // Email
          Expanded(
            child: _detailChip(Icons.email_outlined, user.email),
          ),
          const SizedBox(width: 8),
          // Flip back icon
          Icon(
            Icons.flip_rounded,
            color: Colors.white.withOpacity(0.5),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _detailChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.white.withOpacity(0.6)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _memberSince(UserModel user) {
    final joined = user.joinedAt;
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
                    'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'];
    return '${months[joined.month - 1]} ${joined.year}';
  }
}
