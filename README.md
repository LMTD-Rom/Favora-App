<div align="center">

  # Favora

  <p align="center">
    <strong>Aplikasi kartu member digital dan loyalitas poin berbasis Flutter.</strong>
  </p>

  <p align="center">
    <img src="https://img.shields.io/badge/status-in%20progress%20(~50%25)-amber?style=flat-square" alt="Status" />
    <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter" />
    <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart&logoColor=white" alt="Dart" />
    <img src="https://img.shields.io/badge/State-Riverpod%202-00599C?style=flat-square" alt="Riverpod" />
    <img src="https://img.shields.io/badge/Router-GoRouter-black?style=flat-square" alt="GoRouter" />
  </p>

  ---

  <p align="center">
    <a href="#ikhtisar">Ikhtisar</a> •
    <a href="#progres-pengembangan">Progres</a> •
    <a href="#fitur">Fitur</a> •
    <a href="#arsitektur">Arsitektur</a> •
    <a href="#memulai-lokal">Instalasi</a>
  </p>

</div>

<br />

## Ikhtisar

Favora adalah aplikasi kartu member digital yang menyederhanakan pengumpulan poin, penukaran reward, dan promosi loyalitas pelanggan tanpa kartu fisik. Saat ini proyek berada dalam fase pengembangan aktif (~50%) yang berfokus pada penyelesaian modul backend dan integrasi API.

## Progres Pengembangan

```text
Progress: [██████████░░░░░░░░░░] ~50% Selesai
```

### Selesai (UI & Client-Side Foundation)
- [x] **Design system & theming** — palet warna, tipografi, spacing, dark mode support.
- [x] **Shared components** — glass card, gradient scaffold, shimmer loading, bottom navigation.
- [x] **Onboarding & Auth screens** — splash, onboarding slider, login, dan register UI.
- [x] **State management** — Riverpod architecture dengan mock persistence (`shared_preferences`).
- [x] **Home dashboard** — kartu member digital dinamis, ringkasan poin, quick actions, dan promo banner.
- [x] **QR Member display** — generator QR code unik untuk identifikasi kasir/merchant.
- [x] **Katalog rewards** — listing reward dengan filter kategori dan rincian poin.
- [x] **Riwayat transaksi** — mutasi perolehan poin dan riwayat penukaran reward.
- [x] **Profile screen** — ringkasan akun dan menu preferensi pengguna.

### Dalam Pengerjaan & Rencana (Next Milestone)
- [ ] Integrasi backend API (Supabase / REST service).
- [ ] QR code scanner (kamera merchant untuk claim poin).
- [ ] Logika penukaran voucher dengan validasi kedaluwarsa realtime.
- [ ] Push notifications untuk transaksi dan promo baru.
- [ ] Offline caching & database lokal (Hive / SQLite).
- [ ] Export riwayat transaksi (PDF / CSV).

## Fitur

- **Kartu Member Digital** — tampilan virtual card dengan tier membership, nomor kartu, dan barcode/QR.
- **Akumulasi & Riwayat Poin** — pencatatan mutasi poin otomatis setiap transaksi.
- **Katalog Voucher & Reward** — penukaran poin langsung dengan voucher diskon atau produk mitra.
- **Animasi & Transisi Halus** — integrasi `flutter_animate` dan `flutter_staggered_animations` untuk micro-interaction.

## Arsitektur

```text
lib/
├── core/               # Konfigurasi global, tema, konstanta, helper
│   ├── theme/          # AppColors, AppTypography, AppSpacing, AppTheme
│   ├── router/         # Shell routing & konfigurasi GoRouter
│   └── utils/          # Extensions dan formatters
├── features/           # Modul fitur per domain (feature-first)
│   ├── auth/           # Login, register, splash, onboarding
│   ├── home/           # Dashboard utama, member card, promo banner
│   ├── qr_code/        # Tampilan QR member untuk scanning
│   ├── rewards/        # Katalog & detail penukaran reward
│   ├── history/        # Riwayat perolehan & mutasi poin
│   └── profile/        # Pengaturan & ringkasan akun
├── shared/             # Widget global (glass card, scaffold, shimmer)
└── data/               # Mock data & local storage adapter
```

## Teknologi

- **Framework**: [Flutter](https://flutter.dev/) (Target: Android, iOS)
- **State Management**: [Flutter Riverpod 2.6](https://riverpod.dev/)
- **Routing**: [GoRouter 14](https://pub.dev/packages/go_router)
- **QR Engine**: [qr_flutter](https://pub.dev/packages/qr_flutter)
- **UI & Animations**: Google Fonts, Shimmer, Flutter Animate, Flutter SVG
- **Local Storage**: SharedPreferences

## Memulai Lokal

Pastikan Flutter SDK sudah terpasang di sistem (`flutter doctor`).

```bash
# 1. Clone repositori
git clone https://github.com/LMTD-Rom/Favora-App.git
cd Favora-App

# 2. Ambil paket dependencies
flutter pub get

# 3. Jalankan aplikasi (pilih emulator / physical device)
flutter run
```

---

<div align="center">
  <sub>Favora App • Hak cipta dilindungi.</sub>
</div>
