import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../core/constants.dart';
import '../models/user.dart';
import 'session_service.dart';

/// Mock in-memory auth (frontend-only for now).
class AuthService extends ChangeNotifier {
  final _session = SessionService();
  AppUser? _current;

  // Very simple in-memory user store by email.
  final Map<String, AppUser> _users = {};

  AppUser? get current => _current;
  bool get isLoggedIn => _current != null;

  Future<void> bootstrap() async {
    _current = await _session.loadUser();
    notifyListeners();
  }

  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    // Simulate latency
    await Future.delayed(const Duration(milliseconds: 400));

    // Validation
    if (!AppConst.emailRegex.hasMatch(email)) {
      throw Exception('Invalid email format');
    }
    if (password.length < AppConst.minPasswordLen) {
      throw Exception('Password too short');
    }
    if (_users.containsKey(email.toLowerCase())) {
      throw Exception('Email already registered');
    }

    final user = AppUser(
      id: 'U${100000 + Random().nextInt(900000)}',
      email: email.toLowerCase(),
      role: role,
      name: name.trim(),
    );
    _users[user.email] = user;
    _current = user;
    await _session.saveUser(user);
    notifyListeners();
    return user;
  }

  Future<AppUser> login({
    required String email,
    required String password,
    required String role,
  }) async {
    await Future.delayed(const Duration(milliseconds: 350));

    final u = _users[email.toLowerCase()];
    if (u == null) {
      // Auto-create for demo, but enforce role
      final user = await register(
        name: email.split('@').first,
        email: email,
        password: password,
        role: role,
      );
      return user;
    }
    if (u.role != role) {
      throw Exception('Selected role does not match the account role');
    }
    _current = u;
    await _session.saveUser(u);
    notifyListeners();
    return u;
  }

  Future<void> logout() async {
    _current = null;
    await _session.clear();
    notifyListeners();
  }

  /// Utility for password strength: 0..4
  int passwordStrength(String p) {
    int s = 0;
    if (p.length >= AppConst.minPasswordLen) s++;
    if (RegExp(r'[A-Z]').hasMatch(p)) s++;
    if (RegExp(r'[a-z]').hasMatch(p)) s++;
    if (RegExp(r'[0-9]').hasMatch(p)) s++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(p)) s++;
    return s.clamp(0, 4);
  }
}

