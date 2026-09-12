/// Transaction / Points history model.
class TransactionModel {
  final String id;
  final String title;
  final String titleId;
  final String? storeName;
  final int points;
  final TransactionType type;
  final DateTime createdAt;
  final String? description;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.titleId,
    this.storeName,
    required this.points,
    required this.type,
    required this.createdAt,
    this.description,
  });

  bool get isIncoming => type == TransactionType.earned;
  String get pointsDisplay => isIncoming ? '+$points' : '-$points';
}

enum TransactionType {
  earned,
  redeemed;

  String get displayName {
    switch (this) {
      case TransactionType.earned:
        return 'Earned';
      case TransactionType.redeemed:
        return 'Redeemed';
    }
  }

  String get displayNameId {
    switch (this) {
      case TransactionType.earned:
        return 'Diterima';
      case TransactionType.redeemed:
        return 'Ditukar';
    }
  }
}

/// Notification model.
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final String? actionUrl;
  final NotificationType type;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.actionUrl,
    required this.type,
  });
}

enum NotificationType {
  promo,
  pointsEarned,
  tierUpgrade,
  rewardRedeemed,
  general;
}

/// Promo banner model.
class PromoModel {
  final String id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? actionUrl;
  final List<String> gradientColors;
  final DateTime? expiresAt;

  const PromoModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.actionUrl,
    this.gradientColors = const ['#2563EB', '#7C3AED'],
    this.expiresAt,
  });
}
