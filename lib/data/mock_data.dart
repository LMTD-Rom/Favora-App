import 'package:favora_app/features/auth/domain/user_model.dart';
import 'package:favora_app/features/rewards/domain/reward_model.dart';
import 'package:favora_app/features/history/domain/transaction_model.dart';

/// Mock data for development " will be replaced with Firebase later.
class MockData {
  MockData._();

 // """ Current User """""""""""""""""""""""""""""""""""""""""""
  static final UserModel currentUser = UserModel(
    id: 'usr_001',
    memberId: 'A7F3B2E1',
    name: 'Rina Wulandari',
    email: 'rina.wulandari@email.com',
    phone: '+6281234567890',
    totalPoints: 780,
    availablePoints: 650,
    tier: MemberTier.silver,
    joinedAt: DateTime(2026, 3, 15),
    totalTransactions: 47,
    rewardsRedeemed: 5,
  );

 // """ Rewards Catalog """"""""""""""""""""""""""""""""""""""""
  static final List<RewardModel> rewards = [
    const RewardModel(
      id: 'rwd_001',
      title: '10% Discount Voucher',
      titleId: 'Voucher Diskon 10%',
      description: 'Get 10% off on your next purchase. Valid for all menu items.',
      descriptionId: 'Dapatkan diskon 10% untuk pembelian berikutnya. Berlaku untuk semua menu.',
      pointsCost: 100,
      category: RewardCategory.voucher,
      stockLeft: 50,
    ),
    const RewardModel(
      id: 'rwd_002',
      title: '25% Discount Voucher',
      titleId: 'Voucher Diskon 25%',
      description: 'Get 25% off on your next purchase. Minimum purchase Rp50,000.',
      descriptionId: 'Dapatkan diskon 25% untuk pembelian berikutnya. Minimal belanja Rp50.000.',
      pointsCost: 250,
      category: RewardCategory.voucher,
      minTier: 'silver',
      stockLeft: 20,
    ),
    const RewardModel(
      id: 'rwd_003',
      title: 'Free Ice Coffee',
      titleId: 'Es Kopi Gratis',
      description: 'Redeem for a free iced coffee of any size.',
      descriptionId: 'Tukarkan untuk es kopi gratis ukuran apa saja.',
      pointsCost: 150,
      category: RewardCategory.freeItem,
      stockLeft: 30,
    ),
    const RewardModel(
      id: 'rwd_004',
      title: 'Free Pastry',
      titleId: 'Pastry Gratis',
      description: 'Choose any pastry from our display for free.',
      descriptionId: 'Pilih pastry apa saja dari etalase secara gratis.',
      pointsCost: 200,
      category: RewardCategory.freeItem,
      minTier: 'silver',
      stockLeft: 15,
    ),
    const RewardModel(
      id: 'rwd_005',
      title: 'Birthday Special Package',
      titleId: 'Paket Spesial Ulang Tahun',
      description: 'A special package with cake slice, drink, and surprise gift!',
      descriptionId: 'Paket spesial dengan potongan kue, minuman, dan hadiah kejutan!',
      pointsCost: 500,
      category: RewardCategory.special,
      minTier: 'gold',
      stockLeft: 5,
    ),
    const RewardModel(
      id: 'rwd_006',
      title: '50% Discount Voucher',
      titleId: 'Voucher Diskon 50%',
      description: 'Half price on your next purchase! Gold member exclusive.',
      descriptionId: 'Setengah harga untuk pembelian berikutnya! Eksklusif member Gold.',
      pointsCost: 400,
      category: RewardCategory.voucher,
      minTier: 'gold',
      stockLeft: 10,
    ),
  ];

 // """ Transaction History """"""""""""""""""""""""""""""""""""
  static final List<TransactionModel> transactions = [
    TransactionModel(
      id: 'txn_001',
      title: 'Purchase at Store',
      titleId: 'Pembelian di Toko',
      storeName: 'Favora Cafe Sudirman',
      points: 25,
      type: TransactionType.earned,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    TransactionModel(
      id: 'txn_002',
      title: 'Voucher Redeemed',
      titleId: 'Voucher Ditukar',
      storeName: null,
      points: 100,
      type: TransactionType.redeemed,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      description: '10% Discount Voucher',
    ),
    TransactionModel(
      id: 'txn_003',
      title: 'Purchase at Store',
      titleId: 'Pembelian di Toko',
      storeName: 'Favora Cafe Kemang',
      points: 40,
      type: TransactionType.earned,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TransactionModel(
      id: 'txn_004',
      title: 'Purchase at Store',
      titleId: 'Pembelian di Toko',
      storeName: 'Favora Cafe PIK',
      points: 15,
      type: TransactionType.earned,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
    ),
    TransactionModel(
      id: 'txn_005',
      title: 'Free Item Redeemed',
      titleId: 'Menu Gratis Ditukar',
      storeName: null,
      points: 150,
      type: TransactionType.redeemed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Es Kopi Gratis',
    ),
    TransactionModel(
      id: 'txn_006',
      title: 'Purchase at Store',
      titleId: 'Pembelian di Toko',
      storeName: 'Favora Cafe Sudirman',
      points: 30,
      type: TransactionType.earned,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    TransactionModel(
      id: 'txn_007',
      title: 'Bonus Points',
      titleId: 'Bonus Poin',
      storeName: null,
      points: 50,
      type: TransactionType.earned,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      description: 'Silver tier welcome bonus',
    ),
    TransactionModel(
      id: 'txn_008',
      title: 'Purchase at Store',
      titleId: 'Pembelian di Toko',
      storeName: 'Favora Cafe Kemang',
      points: 20,
      type: TransactionType.earned,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

 // """ Promos """""""""""""""""""""""""""""""""""""""""""""""""
  static final List<PromoModel> promos = [
    PromoModel(
      id: 'promo_001',
      title: 'Kopi Diskon 30%',
      subtitle: 'Khusus hari ini jam 14.00-17.00',
      gradientColors: ['#2563EB', '#7C3AED'],
      expiresAt: DateTime.now().add(const Duration(hours: 5)),
    ),
    PromoModel(
      id: 'promo_002',
      title: 'Double Points Weekend',
      subtitle: 'Setiap Sabtu & Minggu poin 2x lipat!',
      gradientColors: ['#059669', '#10B981'],
      expiresAt: DateTime.now().add(const Duration(days: 3)),
    ),
    PromoModel(
      id: 'promo_003',
      title: 'Ajak Teman, Dapat 100 Poin',
      subtitle: 'Referral bonus untuk kamu dan temanmu',
      gradientColors: ['#DB2777', '#EC4899'],
      expiresAt: DateTime.now().add(const Duration(days: 14)),
    ),
  ];

 // """ Notifications """"""""""""""""""""""""""""""""""""""""""
  static final List<NotificationModel> notifications = [
    NotificationModel(
      id: 'notif_001',
      title: 'Kopi Diskon 30% Hari Ini!',
      body: 'Khusus jam 14.00-17.00, nikmati kopi favoritmu dengan diskon 30%. Jangan sampai lewat!',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      type: NotificationType.promo,
    ),
    NotificationModel(
      id: 'notif_002',
      title: 'Poin Berhasil Ditambahkan',
      body: 'Kamu mendapat +25 poin dari transaksi di Favora Cafe Sudirman.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.pointsEarned,
      isRead: true,
    ),
    NotificationModel(
      id: 'notif_003',
      title: 'Selamat! Kamu Naik ke Silver',
      body: 'Selamat! Kamu sudah mencapai tier Silver. Nikmati bonus poin 1.5x di setiap transaksi.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      type: NotificationType.tierUpgrade,
      isRead: true,
    ),
    NotificationModel(
      id: 'notif_004',
      title: 'Double Points Weekend',
      body: 'Setiap Sabtu & Minggu, dapatkan poin 2x lipat untuk semua transaksi!',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.promo,
    ),
  ];
}

