import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:favora_app/features/auth/domain/user_model.dart';

class AuthService {
  static const String _usersKey = 'favora_users';
  static const String _currentUserKey = 'favora_current_user_email';

  /// Register a new user and save to local storage.
  /// Also logs them in automatically.
  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load existing users
    final usersMap = _loadUsers(prefs);
    
    if (usersMap.containsKey(email)) {
      throw Exception('Email sudah terdaftar');
    }

    // Generate new member
    final id = const Uuid().v4();
    final memberId = 'FVR-${id.substring(0, 8).toUpperCase()}';
    
    final newUser = UserModel(
      id: id,
      memberId: memberId,
      name: name,
      email: email,
      phone: phone,
      totalPoints: 0,
      availablePoints: 0,
      tier: MemberTier.bronze,
      joinedAt: DateTime.now(),
    );

    // Save user data along with password hash (simulated)
    usersMap[email] = {
      'user': newUser.toJson(),
      'password': password, // In a real app, never store plain text!
    };

    await prefs.setString(_usersKey, jsonEncode(usersMap));
    await prefs.setString(_currentUserKey, email);

    return newUser;
  }

  /// Login with email and password
  Future<UserModel> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersMap = _loadUsers(prefs);

    if (!usersMap.containsKey(email)) {
      throw Exception('Email tidak ditemukan');
    }

    final userData = usersMap[email]!;
    if (userData['password'] != password) {
      throw Exception('Password salah');
    }

    await prefs.setString(_currentUserKey, email);
    return UserModel.fromJson(userData['user'] as Map<String, dynamic>);
  }

  /// Logout current user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  /// Get currently logged in user, if any
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentEmail = prefs.getString(_currentUserKey);
    
    if (currentEmail == null) return null;

    final usersMap = _loadUsers(prefs);
    if (!usersMap.containsKey(currentEmail)) return null;

    return UserModel.fromJson(usersMap[currentEmail]!['user'] as Map<String, dynamic>);
  }

  /// Helper to load the users map from SharedPreferences
  Map<String, dynamic> _loadUsers(SharedPreferences prefs) {
    final usersString = prefs.getString(_usersKey);
    if (usersString == null) return {};
    try {
      return jsonDecode(usersString) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}
