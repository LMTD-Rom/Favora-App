import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favora_app/features/auth/domain/user_model.dart';
import 'package:favora_app/features/auth/data/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() async {
    return ref.watch(authServiceProvider).getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(authServiceProvider).login(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(authServiceProvider).register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authServiceProvider).logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
