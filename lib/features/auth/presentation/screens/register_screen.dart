import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_typography.dart';
import 'package:favora_app/core/constants/app_constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favora_app/features/auth/providers/auth_provider.dart';

/// Registration screen with name, email, phone, password.
class RegisterScreen extends ConsumerStatefulWidget {
  final VoidCallback onRegister;
  final VoidCallback onBack;

  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.onBack,
  });

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate() && _agreeTerms) {
      setState(() => _isLoading = true);
      try {
        await ref.read(authNotifierProvider.notifier).register(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
        );
        if (mounted) {
          widget.onRegister();
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
    } else if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus menyetujui syarat & ketentuan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 16,
                bottom: 32,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 20),
                    onPressed: widget.onBack,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Buat Akun Baru',
                    style: AppTypography.headingLarge.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Daftar dan mulai kumpulkan poin!',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
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
                    const SizedBox(height: 20),
                    // Name
                    Text('Nama Lengkap', style: AppTypography.labelLarge),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan nama lengkap',
                        prefixIcon: Icon(Icons.person_outline, size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Nama wajib diisi';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    // Phone
                    Text('Nomor HP', style: AppTypography.labelLarge),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: '08xxxxxxxxxx',
                        prefixIcon: Icon(Icons.phone_outlined, size: 20),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Nomor HP wajib diisi';
                        if (v.length < 10) return 'Nomor HP tidak valid';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password
                    Text('Password', style: AppTypography.labelLarge),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Minimal 6 karakter',
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
                    const SizedBox(height: 20),
                    // Terms checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _agreeTerms,
                            onChanged: (v) =>
                                setState(() => _agreeTerms = v ?? false),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _agreeTerms = !_agreeTerms),
                            child: Text(
                              'Saya setuju dengan Syarat & Ketentuan dan Kebijakan Privasi ${AppConstants.appName}',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // Register button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: (_isLoading || !_agreeTerms)
                            ? null
                            : _handleRegister,
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Daftar'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah punya akun? ',
                          style: AppTypography.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: widget.onBack,
                          child: Text(
                            'Masuk',
                            style: AppTypography.buttonMedium.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 500.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
}

