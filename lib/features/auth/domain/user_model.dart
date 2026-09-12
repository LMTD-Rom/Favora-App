import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/constants/app_constants.dart';

enum MemberTier {
  bronze,
  silver,
  gold;

  String get displayName {
    switch (this) {
      case MemberTier.bronze:
        return 'Bronze';
      case MemberTier.silver:
        return 'Silver';
      case MemberTier.gold:
        return 'Gold';
    }
  }

  String get displayNameId {
    switch (this) {
      case MemberTier.bronze:
        return 'Perunggu';
      case MemberTier.silver:
        return 'Perak';
      case MemberTier.gold:
        return 'Emas';
    }
  }

  Color get color {
    switch (this) {
      case MemberTier.bronze:
        return AppColors.tierBronze;
      case MemberTier.silver:
        return AppColors.tierSilver;
      case MemberTier.gold:
        return AppColors.tierGold;
    }
  }

  Color get lightColor {
    switch (this) {
      case MemberTier.bronze:
        return AppColors.tierBronzeLight;
      case MemberTier.silver:
        return AppColors.tierSilverLight;
      case MemberTier.gold:
        return AppColors.tierGoldLight;
    }
  }

  LinearGradient get gradient {
    switch (this) {
      case MemberTier.bronze:
        return AppColors.bronzeGradient;
      case MemberTier.silver:
        return AppColors.silverGradient;
      case MemberTier.gold:
        return AppColors.goldGradient;
    }
  }

  IconData get icon {
    switch (this) {
      case MemberTier.bronze:
        return Icons.shield_outlined;
      case MemberTier.silver:
        return Icons.shield;
      case MemberTier.gold:
        return Icons.workspace_premium;
    }
  }

  int get minPoints {
    switch (this) {
      case MemberTier.bronze:
        return AppConstants.tierBronzeMin;
      case MemberTier.silver:
        return AppConstants.tierSilverMin;
      case MemberTier.gold:
        return AppConstants.tierGoldMin;
    }
  }

  double get multiplier {
    switch (this) {
      case MemberTier.bronze:
        return 1.0;
      case MemberTier.silver:
        return AppConstants.silverMultiplier;
      case MemberTier.gold:
        return AppConstants.goldMultiplier;
    }
  }

  MemberTier? get nextTier {
    switch (this) {
      case MemberTier.bronze:
        return MemberTier.silver;
      case MemberTier.silver:
        return MemberTier.gold;
      case MemberTier.gold:
        return null;
    }
  }

  /// Calculate tier from total points.
  static MemberTier fromPoints(int points) {
    if (points >= AppConstants.tierGoldMin) return MemberTier.gold;
    if (points >= AppConstants.tierSilverMin) return MemberTier.silver;
    return MemberTier.bronze;
  }
}

/// User / Member model.
class UserModel {
  final String id;
  final String memberId;
  final String name;
  final String email;
  final String phone;
  final String? avatarUrl;
  final int totalPoints;
  final int availablePoints;
  final MemberTier tier;
  final DateTime joinedAt;
  final int totalTransactions;
  final int rewardsRedeemed;

  const UserModel({
    required this.id,
    required this.memberId,
    required this.name,
    required this.email,
    required this.phone,
    this.avatarUrl,
    required this.totalPoints,
    required this.availablePoints,
    required this.tier,
    required this.joinedAt,
    this.totalTransactions = 0,
    this.rewardsRedeemed = 0,
  });

  /// Points needed to reach next tier.
  int get pointsToNextTier {
    final next = tier.nextTier;
    if (next == null) return 0;
    return next.minPoints - totalPoints;
  }

  /// Progress percentage to next tier (0.0 - 1.0).
  double get tierProgress {
    final next = tier.nextTier;
    if (next == null) return 1.0;
    final range = next.minPoints - tier.minPoints;
    final progress = totalPoints - tier.minPoints;
    return (progress / range).clamp(0.0, 1.0);
  }

  UserModel copyWith({
    String? id,
    String? memberId,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    int? totalPoints,
    int? availablePoints,
    MemberTier? tier,
    DateTime? joinedAt,
    int? totalTransactions,
    int? rewardsRedeemed,
  }) {
    return UserModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      totalPoints: totalPoints ?? this.totalPoints,
      availablePoints: availablePoints ?? this.availablePoints,
      tier: tier ?? this.tier,
      joinedAt: joinedAt ?? this.joinedAt,
      totalTransactions: totalTransactions ?? this.totalTransactions,
      rewardsRedeemed: rewardsRedeemed ?? this.rewardsRedeemed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'totalPoints': totalPoints,
      'availablePoints': availablePoints,
      'tier': tier.name,
      'joinedAt': joinedAt.toIso8601String(),
      'totalTransactions': totalTransactions,
      'rewardsRedeemed': rewardsRedeemed,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      memberId: json['memberId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      totalPoints: json['totalPoints'] as int,
      availablePoints: json['availablePoints'] as int,
      tier: MemberTier.values.firstWhere(
        (e) => e.name == json['tier'],
        orElse: () => MemberTier.bronze,
      ),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      totalTransactions: json['totalTransactions'] as int,
      rewardsRedeemed: json['rewardsRedeemed'] as int,
    );
  }
}
