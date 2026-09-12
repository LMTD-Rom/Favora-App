import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/constants/app_constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favora_app/features/auth/providers/auth_provider.dart';

/// Login screen with email/password form.
class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authNotifierProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
        );
        if (mounted) {
          widget.onLogin();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with gradient
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 40,
                bottom: 40,
              ),
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.glassWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: const Icon(
                      Icons.card_membership_rounded,
                      size: 36,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 500.ms).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppConstants.appName,
                    style: AppTypography.displayMedium.copyWith(
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 4),
                  Text(
                    'Masuk ke akunmu',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ).animate().fadeIn(delay: 300.ms),
                ],
              ),
            ),
            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Email
                    Text('Email', style: AppTypography.labelLarge),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'nama@email.com',
                        prefixIcon: Icon(Icons.email_outlined, size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email wajib diisi';
                        if (!v.contains('@')) return 'Email tidak valid';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Password
                    Text('Password', style: AppTypography.labelLarge),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Password wajib diisi';
                        if (v.length < 6) return 'Minimal 6 karakter';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lupa Password?',
                          style: AppTypography.buttonSmall.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Masuk'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'atau',
                            style: AppTypography.bodySmall,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Google Sign In
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: _handleLogin,
                        icon: const Icon(Icons.g_mobiledata_rounded, size: 28),
                        label: const Text('Masuk dengan Google'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: AppTypography.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: widget.onRegister,
                          child: Text(
                            'Daftar Sekarang',
                            style: AppTypography.buttonMedium.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
}
