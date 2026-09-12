/// Favora - Constants
///
/// Tier thresholds, app configuration, and business logic constants.
class AppConstants {
  AppConstants._();

  // --- App Info -----------------------------------------------
  static const String appName = 'Favora';
  static const String appTagline = 'Your Loyalty, Your Rewards';
  static const String appTaglineId = 'Loyalitasmu, Hadiahmu';

  // --- Tier Thresholds ----------------------------------------
  static const int tierBronzeMin = 0;
  static const int tierSilverMin = 500;
  static const int tierGoldMin = 1500;

  // --- QR Code ------------------------------------------------
  static const int qrRefreshIntervalSeconds = 30;
  static const double qrSize = 220;

  // --- Points -------------------------------------------------
  static const int pointsPerTransaction = 10; // Base points per transaction
  static const double silverMultiplier = 1.5;
  static const double goldMultiplier = 2.0;

  // --- Animation Durations ------------------------------------
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);
  static const Duration animVerySlow = Duration(milliseconds: 800);

  // --- Storage Keys -------------------------------------------
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyUserToken = 'user_token';
  static const String keyLocale = 'locale';
}
