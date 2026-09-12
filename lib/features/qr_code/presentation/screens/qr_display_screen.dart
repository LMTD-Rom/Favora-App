import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/core/constants/app_constants.dart';
import 'package:favora_app/core/utils/formatters.dart';
import 'package:favora_app/data/mock_data.dart';

/// Full-screen QR code display for cashier scanning.
/// QR refreshes every 30 seconds for security.
class QrDisplayScreen extends StatefulWidget {
  const QrDisplayScreen({super.key});

  @override
  State<QrDisplayScreen> createState() => _QrDisplayScreenState();
}

class _QrDisplayScreenState extends State<QrDisplayScreen> {
  late Timer _timer;
  int _countdown = AppConstants.qrRefreshIntervalSeconds;
  String _qrData = '';

  @override
  void initState() {
    super.initState();
    _generateQrData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _countdown--;
        if (_countdown <= 0) {
          _countdown = AppConstants.qrRefreshIntervalSeconds;
          _generateQrData();
        }
      });
    });
    // Max brightness
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
    );
  }

  void _generateQrData() {
    final user = MockData.currentUser;
    _qrData =
        'FAVORA:${user.memberId}:${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    Text(
                      'QR Member',
                      style: AppTypography.titleLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const Spacer(),
              // QR Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppSpacing.borderRadiusXxl,
                  boxShadow: AppColors.elevatedShadow,
                ),
                child: Column(
                  children: [
                    // Tier badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: user.tier.gradient,
                        borderRadius: AppSpacing.borderRadiusFull,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(user.tier.icon, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            '${user.tier.displayName} Member',
                            style: AppTypography.labelLarge.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.name,
                      style: AppTypography.headingMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppFormatters.memberId(user.memberId),
                      style: AppTypography.labelMedium.copyWith(
                        fontFamily: 'monospace',
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // QR Code
                    QrImageView(
                      data: _qrData,
                      version: QrVersions.auto,
                      size: AppConstants.qrSize,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: AppColors.primaryDark,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: AppColors.primaryDark,
                      ),
                    ).animate().fadeIn(duration: 300.ms).scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                    ),
                    const SizedBox(height: 20),
                    // Refresh countdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          size: 16,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Refresh dalam $_countdown detik',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Progress bar
                    ClipRRect(
                      borderRadius: AppSpacing.borderRadiusFull,
                      child: LinearProgressIndicator(
                        value: _countdown /
                            AppConstants.qrRefreshIntervalSeconds,
                        backgroundColor: AppColors.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _countdown > 10
                              ? AppColors.accent
                              : AppColors.warning,
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(
                begin: 0.1,
                end: 0,
                curve: Curves.easeOutCubic,
              ),
              const SizedBox(height: 24),
              // Instructions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'Tunjukkan QR ini ke kasir saat melakukan pembayaran untuk mendapatkan poin',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              // Points info
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.glassWhite,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoItem(
                      label: 'Poin Tersedia',
                      value: AppFormatters.number(user.availablePoints),
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: AppColors.glassBorder,
                    ),
                    _InfoItem(
                      label: 'Total Poin',
                      value: AppFormatters.number(user.totalPoints),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.headingSmall.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}


