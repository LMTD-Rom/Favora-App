import 'package:flutter/material.dart';
import 'package:favora_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:favora_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:favora_app/features/auth/presentation/screens/login_screen.dart';
import 'package:favora_app/features/auth/presentation/screens/register_screen.dart';
import 'package:favora_app/features/home/presentation/screens/home_screen.dart';
import 'package:favora_app/features/qr_code/presentation/screens/qr_display_screen.dart';
import 'package:favora_app/features/rewards/presentation/screens/rewards_catalog_screen.dart';
import 'package:favora_app/features/history/presentation/screens/history_screen.dart';
import 'package:favora_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:favora_app/shared/widgets/gradient_scaffold.dart';
import 'package:favora_app/shared/widgets/app_bottom_nav.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favora_app/features/auth/providers/auth_provider.dart';

/// Main app shell with navigation state management.
///
/// Uses a simple stateful approach for now - can be migrated
/// to GoRouter later when Firebase auth is integrated.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

enum AppState { splash, onboarding, login, register, home }

class _AppShellState extends ConsumerState<AppShell> {
  AppState _state = AppState.splash;
  int _currentNavIndex = 0;

  void _navigate(AppState state) {
    setState(() => _state = state);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    switch (_state) {
      case AppState.splash:
        return SplashScreen(
          onFinished: () {
            if (authState.value != null) {
              _navigate(AppState.home);
            } else {
              _navigate(AppState.onboarding);
            }
          },
        );
      case AppState.onboarding:
        return OnboardingScreen(
          onComplete: () => _navigate(AppState.login),
        );
      case AppState.login:
        return LoginScreen(
          onLogin: () => _navigate(AppState.home),
          onRegister: () => _navigate(AppState.register),
        );
      case AppState.register:
        return RegisterScreen(
          onRegister: () => _navigate(AppState.home),
          onBack: () => _navigate(AppState.login),
        );
      case AppState.home:
        return _buildMainShell();
    }
  }

  Widget _buildMainShell() {
    return GradientScaffold(
      gradientHeight: _currentNavIndex == 0 ? 320 : 0,
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          if (index == 2) {
            // Center QR button - open full screen QR
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const QrDisplayScreen(),
              ),
            );
          } else {
            setState(() => _currentNavIndex = index);
          }
        },
      ),
      body: IndexedStack(
        index: _currentNavIndex > 2 ? _currentNavIndex - 1 : _currentNavIndex,
        children: [
          // 0: Home
          HomeScreen(
            onQrTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const QrDisplayScreen()),
            ),
            onRewardsTap: () => setState(() => _currentNavIndex = 1),
            onHistoryTap: () => setState(() => _currentNavIndex = 3),
            onNotificationsTap: () {},
          ),
          // 1: Rewards
          const RewardsCatalogScreen(),
          // 3 -> index 2: History
          const HistoryScreen(),
          // 4 -> index 3: Profile
          ProfileScreen(
            onLogout: () => _navigate(AppState.login),
          ),
        ],
      ),
    );
  }
}
