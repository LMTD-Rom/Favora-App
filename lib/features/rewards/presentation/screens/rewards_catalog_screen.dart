import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/data/mock_data.dart';
import 'package:favora_app/features/rewards/domain/reward_model.dart';

/// Rewards catalog with category tabs and grid display.
class RewardsCatalogScreen extends StatefulWidget {
  const RewardsCatalogScreen({super.key});

  @override
  State<RewardsCatalogScreen> createState() => _RewardsCatalogScreenState();
}

class _RewardsCatalogScreenState extends State<RewardsCatalogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _categories = [
    null, // All
    RewardCategory.voucher,
    RewardCategory.freeItem,
    RewardCategory.special,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<RewardModel> _filteredRewards(RewardCategory? category) {
    if (category == null) return MockData.rewards;
    return MockData.rewards.where((r) => r.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.paddingOf(context).top + 16),
        // Title
        Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Katalog Rewards', style: AppTypography.headingLarge),
              const SizedBox(height: 4),
              Text(
                'Tukarkan poinmu dengan hadiah menarik',
                style: AppTypography.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Tabs
        TabBar(
          controller: _tabController,
          isScrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Voucher'),
            Tab(text: 'Menu Gratis'),
            Tab(text: 'Spesial'),
          ],
        ),
        const SizedBox(height: 16),
        // Grid
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _categories.map((cat) {
              final rewards = _filteredRewards(cat);
              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  return _RewardCard(reward: rewards[index])
                      .animate()
                      .fadeIn(delay: (index * 100).ms, duration: 400.ms)
                      .slideY(begin: 0.1, end: 0);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _RewardCard extends StatelessWidget {
  final RewardModel reward;

  const _RewardCard({required this.reward});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;
    final canAfford = user.availablePoints >= reward.pointsCost;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: AppSpacing.borderRadiusLg,
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder with category gradient
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _categoryColors(reward.category),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    _categoryIcon(reward.category),
                    size: 40,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                // Stock badge
                if (reward.hasLimitedStock)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: AppSpacing.borderRadiusFull,
                      ),
                      child: Text(
                        'Sisa ${reward.stockLeft}',
                        style: AppTypography.tag.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.titleId,
                    style: AppTypography.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Points cost + CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.stars_rounded,
                              size: 14, color: AppColors.warning),
                          const SizedBox(width: 4),
                          Text(
                            '${reward.pointsCost}',
                            style: AppTypography.titleMedium.copyWith(
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: canAfford
                              ? AppColors.primaryLight
                              : AppColors.surfaceVariant,
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          'Tukar',
                          style: AppTypography.buttonSmall.copyWith(
                            color: canAfford
                                ? Colors.white
                                : AppColors.textTertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _categoryColors(RewardCategory category) {
    switch (category) {
      case RewardCategory.voucher:
        return [const Color(0xFF2563EB), const Color(0xFF3B82F6)];
      case RewardCategory.freeItem:
        return [const Color(0xFF059669), const Color(0xFF10B981)];
      case RewardCategory.special:
        return [const Color(0xFFDB2777), const Color(0xFFEC4899)];
    }
  }

  IconData _categoryIcon(RewardCategory category) {
    switch (category) {
      case RewardCategory.voucher:
        return Icons.local_offer_rounded;
      case RewardCategory.freeItem:
        return Icons.restaurant_rounded;
      case RewardCategory.special:
        return Icons.auto_awesome_rounded;
    }
  }
}
