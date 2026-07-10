import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  static const _secure = FlutterSecureStorage();

  static const _kToken = 'auth_token';
  static const _kUserId = 'user_id';
  static const _kIsLoggedIn = 'is_logged_in';
  static const _kAvailabilityCache = 'availability_cache';
  static const _kProfileCache = 'psychologist_profile_cache';
  static const _kProfileCompleted = 'profile_completed';
  static const _kUsername = 'username';

  Future<void> saveSession({
    required String token,
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await _secure.write(key: _kToken, value: token);
    await prefs.setString(_kUserId, userId);
    await prefs.setBool(_kIsLoggedIn, true);
  }

  Future<String?> readToken() => _secure.read(key: _kToken);

  Future<String?> readUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserId);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsLoggedIn) ?? false;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await _secure.delete(key: _kToken);
    await prefs.remove(_kUserId);
    await prefs.setBool(_kIsLoggedIn, false);
  }

  Future<void> saveAvailabilityCache(String raw) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAvailabilityCache, raw);
  }

  Future<String?> readAvailabilityCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAvailabilityCache);
  }

  Future<void> saveProfileCache(Map<String, dynamic> profile) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_kProfileCache, jsonEncode(profile));
  }

  Future<Map<String, dynamic>?> readProfileCache() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = prefs.getString(_kProfileCache);

    if (raw == null) return null;

    return Map<String, dynamic>.from(jsonDecode(raw));
  }

  Future<void> setProfileCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_kProfileCompleted, value);
  }

  Future<bool> isProfileCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kProfileCompleted) ?? false;
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kUsername, username);
  }

  Future<String?> readUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUsername);
  }
}
