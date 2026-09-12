import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/core/utils/formatters.dart';
import 'package:favora_app/data/mock_data.dart';
import 'package:favora_app/features/history/domain/transaction_model.dart';

/// Transaction history with tab filter (All / Earned / Redeemed).
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<TransactionModel> _filtered(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return MockData.transactions
            .where((t) => t.type == TransactionType.earned)
            .toList();
      case 2:
        return MockData.transactions
            .where((t) => t.type == TransactionType.redeemed)
            .toList();
      default:
        return MockData.transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.paddingOf(context).top + 16),
        Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Riwayat Poin', style: AppTypography.headingLarge),
              const SizedBox(height: 4),
              Text(
                'Semua transaksi poinmu',
                style: AppTypography.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Tabs
        TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Masuk'),
            Tab(text: 'Keluar'),
          ],
        ),
        // List
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [0, 1, 2].map((tabIndex) {
              final txs = _filtered(tabIndex);
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                itemCount: txs.length,
                itemBuilder: (context, index) {
                  final tx = txs[index];
                  final showDateHeader = index == 0 ||
                      !_isSameDay(
                          txs[index - 1].createdAt, tx.createdAt);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDateHeader) ...[
                        if (index > 0) const SizedBox(height: 16),
                        _DateHeader(date: tx.createdAt),
                        const SizedBox(height: 8),
                      ],
                      _HistoryTile(transaction: tx)
                          .animate()
                          .fadeIn(
                            delay: (index * 80).ms,
                            duration: 400.ms,
                          )
                          .slideX(begin: 0.05, end: 0),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _DateHeader extends StatelessWidget {
  final DateTime date;

  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    String label;
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      label = 'Hari Ini';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      label = 'Kemarin';
    } else {
      label = AppFormatters.date(date);
    }

    return Text(
      label,
      style: AppTypography.labelMedium.copyWith(
        color: AppColors.textTertiary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final TransactionModel transaction;

  const _HistoryTile({required this.transaction});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.titleId, style: AppTypography.titleMedium),
                const SizedBox(height: 2),
                Text(
                  transaction.storeName ??
                      transaction.description ??
                      '',
                  style: AppTypography.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
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


