import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/core/utils/formatters.dart';
import 'package:favora_app/data/mock_data.dart';
import 'package:favora_app/features/auth/domain/user_model.dart';
import 'package:favora_app/features/history/domain/transaction_model.dart';
import 'package:favora_app/features/home/presentation/widgets/member_card_widget.dart';
import 'package:favora_app/features/home/presentation/widgets/points_summary.dart';
import 'package:favora_app/features/home/presentation/widgets/quick_actions.dart';
import 'package:favora_app/features/home/presentation/widgets/promo_banner.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favora_app/features/auth/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  final VoidCallback onQrTap;
  final VoidCallback onRewardsTap;
  final VoidCallback onHistoryTap;
  final VoidCallback onNotificationsTap;

  const HomeScreen({
    super.key,
    required this.onQrTap,
    required this.onRewardsTap,
    required this.onHistoryTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.value ?? MockData.currentUser;
    final transactions = MockData.transactions.take(3).toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: _buildHeader(context, user),
        ),
        // Member Card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: MemberCardWidget(
              user: user,
              onQrTap: onQrTap,
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideY(begin: 0.15, end: 0),
          ),
        ),
        // Points Summary
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: PointsSummary(user: user)
                .animate()
                .fadeIn(delay: 300.ms, duration: 500.ms),
          ),
        ),
        // Quick Actions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: QuickActions(
              onQrTap: onQrTap,
              onRewardsTap: onRewardsTap,
              onHistoryTap: onHistoryTap,
              onPromoTap: () {},
            ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
          ),
        ),
        // Promo Banner
        SliverToBoxAdapter(
          child: PromoBanner(promos: MockData.promos)
              .animate()
              .fadeIn(delay: 500.ms, duration: 500.ms),
        ),
        // Recent Transactions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transaksi Terakhir', style: AppTypography.titleLarge),
                GestureDetector(
                  onTap: onHistoryTap,
                  child: Text(
                    'Lihat Semua',
                    style: AppTypography.buttonSmall.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          sliver: SliverList.separated(
            itemCount: transactions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return _TransactionTile(transaction: tx)
                  .animate()
                  .fadeIn(delay: (700 + index * 100).ms, duration: 400.ms)
                  .slideX(begin: 0.05, end: 0);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, UserModel user) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 16,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${user.name.split(' ').first}!',
                  style: AppTypography.headingMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selamat datang kembali',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Notification bell
          GestureDetector(
            onTap: onNotificationsTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.glassWhite,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms),
    );
  }
}

/// Single transaction item tile.
class _TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isEarned = transaction.isIncoming;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: AppSpacing.borderRadiusMd,
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isEarned
                  ? AppColors.accent.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Icon(
              isEarned
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: isEarned ? AppColors.accent : AppColors.error,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.titleId,
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.storeName ??
                      transaction.description ??
                      '',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          // Points
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.pointsDisplay,
                style: AppTypography.titleMedium.copyWith(
                  color: isEarned ? AppColors.accent : AppColors.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                AppFormatters.relativeTime(transaction.createdAt),
                style: AppTypography.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


