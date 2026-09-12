import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/theme/app_spacing.dart';
import 'package:favora_app/core/utils/formatters.dart';
import 'package:favora_app/data/mock_data.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favora_app/features/auth/providers/auth_provider.dart';
import 'package:favora_app/features/auth/domain/user_model.dart';

/// User profile screen with stats, settings, and actions.
class ProfileScreen extends ConsumerWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.value ?? MockData.currentUser;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 16),
          // Header card
          Padding(
            padding: AppSpacing.screenPadding,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: AppSpacing.borderRadiusXl,
                boxShadow: AppColors.elevatedShadow,
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.glassWhite,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2),
                    ),
                    child: Center(
                      child: Text(
                        user.name
                            .split(' ')
                            .map((w) => w.isNotEmpty ? w[0] : '')
                            .take(2)
                            .join(),
                        style: AppTypography.headingLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: AppTypography.headingMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppFormatters.memberId(user.memberId),
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'monospace',
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tier badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
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
                          '${user.tier.displayName} Member',
                          style: AppTypography.labelMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
          ),
          const SizedBox(height: 20),
          // Stats row
          Padding(
            padding: AppSpacing.screenPadding,
            child: Row(
              children: [
                _StatCard(
                  icon: Icons.stars_rounded,
                  value: AppFormatters.number(user.totalPoints),
                  label: 'Total Poin',
                  color: AppColors.primaryLight,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  icon: Icons.card_giftcard_rounded,
                  value: '${user.rewardsRedeemed}',
                  label: 'Reward Ditukar',
                  color: AppColors.accent,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  icon: Icons.receipt_long_rounded,
                  value: '${user.totalTransactions}',
                  label: 'Transaksi',
                  color: AppColors.warning,
                ),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
          ),
          const SizedBox(height: 24),
          // Menu list
          Padding(
            padding: AppSpacing.screenPadding,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: AppSpacing.borderRadiusLg,
                boxShadow: AppColors.cardShadow,
              ),
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.person_outline,
                    label: 'Edit Profil',
                    onTap: () => _showEditProfile(context, user),
                  ),
                  _divider(),
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Pengaturan Notifikasi',
                    onTap: () => _showNotificationSettings(context),
                  ),
                  _divider(),
                  _MenuItem(
                    icon: Icons.language_outlined,
                    label: 'Bahasa / Language',
                    trailing: 'Indonesia',
                    onTap: () => _showLanguageSelector(context),
                  ),
                  _divider(),
                  _MenuItem(
                    icon: Icons.info_outline,
                    label: 'Tentang Favora',
                    onTap: () => _showAboutFavora(context),
                  ),
                  _divider(),
                  _MenuItem(
                    icon: Icons.headset_mic_outlined,
                    label: 'Hubungi Kami',
                    onTap: () => _showContactUs(context),
                  ),
                  _divider(),
                  _MenuItem(
                    icon: Icons.logout_rounded,
                    label: 'Keluar',
                    isDestructive: true,
                    onTap: () => _showLogoutConfirmation(context, ref),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
          ),
          const SizedBox(height: 24),
          // Version
          Text(
            'Favora v1.0.0',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: AppColors.borderLight),
    );
  }

  // --- Edit Profile ---
  void _showEditProfile(BuildContext context, UserModel user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Edit Profil', style: AppTypography.headingMedium),
              const SizedBox(height: 20),
              _buildTextField('Nama Lengkap', nameController, Icons.person_outline),
              const SizedBox(height: 14),
              _buildTextField('Email', emailController, Icons.email_outlined),
              const SizedBox(height: 14),
              _buildTextField('No. Telepon', phoneController, Icons.phone_outlined),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Profil berhasil diperbarui'),
                        backgroundColor: AppColors.accent,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  child: const Text('Simpan Perubahan'),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
      ),
    );
  }

  // --- Notification Settings ---
  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _NotificationSettingsSheet(),
    );
  }

  // --- Language Selector ---
  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        String selected = 'id';
        return StatefulBuilder(
          builder: (context, setModalState) => Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.borderLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Pilih Bahasa / Select Language', style: AppTypography.headingMedium),
                  const SizedBox(height: 20),
                  _LanguageOption(
                    flag: 'ID',
                    title: 'Indonesia',
                    subtitle: 'Bahasa Indonesia',
                    isSelected: selected == 'id',
                    onTap: () {
                      setModalState(() => selected = 'id');
                      Future.delayed(const Duration(milliseconds: 300), () {
                        if (context.mounted) Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Bahasa diubah ke Indonesia'),
                            backgroundColor: AppColors.accent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _LanguageOption(
                    flag: 'EN',
                    title: 'English',
                    subtitle: 'English (US)',
                    isSelected: selected == 'en',
                    onTap: () {
                      setModalState(() => selected = 'en');
                      Future.delayed(const Duration(milliseconds: 300), () {
                        if (context.mounted) Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Language changed to English'),
                            backgroundColor: AppColors.accent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- About Favora ---
  void _showAboutFavora(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const _AboutFavoraPage()),
    );
  }

  // --- Contact Us ---
  void _showContactUs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Hubungi Kami', style: AppTypography.headingMedium),
              const SizedBox(height: 6),
              Text(
                'Kami siap membantu Anda!',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 20),
              _ContactTile(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'support@favora.id',
                color: AppColors.primaryLight,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _ContactTile(
                icon: Icons.phone_outlined,
                title: 'Telepon',
                subtitle: '+62 21 1234 5678',
                color: AppColors.accent,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _ContactTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'WhatsApp',
                subtitle: '+62 812 3456 7890',
                color: Color(0xFF25D366),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _ContactTile(
                icon: Icons.camera_alt_outlined,
                title: 'Instagram',
                subtitle: '@favora.id',
                color: Color(0xFFE1306C),
                onTap: () {},
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Logout Confirmation ---
  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Keluar dari Favora?', style: AppTypography.titleLarge),
        content: Text(
          'Anda akan keluar dari akun Anda. Pastikan data Anda sudah tersimpan.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: AppTypography.buttonMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context); // close dialog
              await ref.read(authNotifierProvider.notifier).logout();
              onLogout(); // navigate to login
            },
            child: Text(
              'Ya, Keluar',
              style: AppTypography.buttonMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Sub-widgets ---

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: AppSpacing.borderRadiusMd,
          boxShadow: AppColors.softShadow,
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final bool isDestructive;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: AppTypography.bodySmall,
              ),
            if (!isDestructive)
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: AppColors.textTertiary,
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationSettingsSheet extends StatefulWidget {
  @override
  State<_NotificationSettingsSheet> createState() => _NotificationSettingsSheetState();
}

class _NotificationSettingsSheetState extends State<_NotificationSettingsSheet> {
  bool promo = true;
  bool transaksi = true;
  bool rewards = true;
  bool update = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Pengaturan Notifikasi', style: AppTypography.headingMedium),
            const SizedBox(height: 6),
            Text(
              'Kelola notifikasi yang ingin Anda terima',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 20),
            _notifSwitch('Promo & Penawaran', 'Diskon dan promo eksklusif untuk Anda', promo, (v) => setState(() => promo = v)),
            _notifSwitch('Transaksi', 'Poin masuk dan keluar dari akun Anda', transaksi, (v) => setState(() => transaksi = v)),
            _notifSwitch('Rewards', 'Reward baru tersedia dan pengingat tukar poin', rewards, (v) => setState(() => rewards = v)),
            _notifSwitch('Update Aplikasi', 'Fitur baru dan pembaruan sistem', update, (v) => setState(() => update = v)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _notifSwitch(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primaryLight,
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryLight.withOpacity(0.08)
              : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  flag,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleMedium),
                  Text(subtitle, style: AppTypography.bodySmall),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: AppColors.primaryLight, size: 24),
          ],
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleMedium),
                  Text(subtitle, style: AppTypography.bodySmall),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}

// --- About Favora Page ---
class _AboutFavoraPage extends StatelessWidget {
  const _AboutFavoraPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Tentang Favora', style: AppTypography.titleLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Logo
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(22),
                boxShadow: AppColors.elevatedShadow,
              ),
              child: const Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Favora', style: AppTypography.headingLarge),
            const SizedBox(height: 4),
            Text(
              'Member & Loyalty App',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Versi 1.0.0',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 32),

            // Description card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: AppSpacing.borderRadiusLg,
                boxShadow: AppColors.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Apa itu Favora?', style: AppTypography.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Favora adalah aplikasi keanggotaan dan loyalitas pelanggan yang dirancang untuk memberikan pengalaman belanja yang lebih baik. '
                    'Kumpulkan poin dari setiap transaksi, tukarkan dengan reward eksklusif, dan nikmati promo-promo spesial yang disesuaikan untuk Anda.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Features
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: AppSpacing.borderRadiusLg,
                boxShadow: AppColors.softShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fitur Utama', style: AppTypography.titleLarge),
                  const SizedBox(height: 12),
                  _featureRow(Icons.qr_code_rounded, 'QR Code Member', 'Identitas digital tanpa kartu fisik'),
                  _featureRow(Icons.stars_rounded, 'Sistem Poin', 'Kumpulkan poin di setiap transaksi'),
                  _featureRow(Icons.card_giftcard_rounded, 'Tukar Reward', 'Reward eksklusif untuk member'),
                  _featureRow(Icons.local_offer_rounded, 'Promo Spesial', 'Penawaran terbaik hanya untuk Anda'),
                  _featureRow(Icons.trending_up_rounded, 'Tier Member', 'Level up untuk benefit lebih banyak'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Credits
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primary,
                  ],
                ),
                borderRadius: AppSpacing.borderRadiusLg,
                boxShadow: AppColors.elevatedShadow,
              ),
              child: Column(
                children: [
                  const Icon(Icons.code_rounded, color: Colors.white, size: 28),
                  const SizedBox(height: 10),
                  Text(
                    'Developed with passion by',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Favora Development Team',
                    style: AppTypography.headingMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Built with Flutter',
                      style: AppTypography.labelMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Legal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: AppSpacing.borderRadiusLg,
                boxShadow: AppColors.softShadow,
              ),
              child: Column(
                children: [
                  _legalRow('Kebijakan Privasi', () {}),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Divider(height: 1, color: AppColors.borderLight),
                  ),
                  _legalRow('Syarat & Ketentuan', () {}),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Divider(height: 1, color: AppColors.borderLight),
                  ),
                  _legalRow('Lisensi Open Source', () {
                    showLicensePage(
                      context: context,
                      applicationName: 'Favora',
                      applicationVersion: '1.0.0',
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Footer
            Text(
              '2026 Favora. All rights reserved.',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryLight, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleMedium),
                Text(subtitle, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legalRow(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
