/// Reward model for the catalog.
class RewardModel {
  final String id;
  final String title;
  final String titleId;
  final String description;
  final String descriptionId;
  final int pointsCost;
  final String? imageUrl;
  final RewardCategory category;
  final String? minTier; // 'bronze', 'silver', 'gold'
  final bool isAvailable;
  final DateTime? expiresAt;
  final int stockLeft;

  const RewardModel({
    required this.id,
    required this.title,
    required this.titleId,
    required this.description,
    required this.descriptionId,
    required this.pointsCost,
    this.imageUrl,
    required this.category,
    this.minTier,
    this.isAvailable = true,
    this.expiresAt,
    this.stockLeft = -1,
  });

  bool get hasLimitedStock => stockLeft >= 0;
  bool get isOutOfStock => hasLimitedStock && stockLeft == 0;
}

enum RewardCategory {
  voucher,
  freeItem,
  special;

  String get displayName {
    switch (this) {
      case RewardCategory.voucher:
        return 'Voucher';
      case RewardCategory.freeItem:
        return 'Free Item';
      case RewardCategory.special:
        return 'Special';
    }
  }

  String get displayNameId {
    switch (this) {
      case RewardCategory.voucher:
        return 'Voucher Diskon';
      case RewardCategory.freeItem:
        return 'Menu Gratis';
      case RewardCategory.special:
        return 'Spesial';
    }
  }
}
