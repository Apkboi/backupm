import 'dart:convert';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/features/authentication/data/models/auth_success_response.dart';
// import 'package:mentra/features/authentication/signup/data/models/signup_response.dart';

class UserStorage {
  // static const _kUserTokenKey = StorageKeys.token;

  UserStorage();

  // Save user data to SharedPreferences
  Future<void> saveUser(dynamic user) async {
    final userJson = jsonEncode(user.toJson());
    SessionManager.instance.usersData = user.toJson();
  }

  // Retrieve user data from SharedPreferences
  Future<MentraUser?> getUser() async {
    final userJson = SessionManager.instance.usersData;
    if (userJson != null) {
      return MentraUser.fromJson(userJson as Map<String, dynamic>);
    }
    return null;

    /// Return null if user data doesn't exist
  }

  // Clear user data from SharedPreferences
  Future<void> clearUser() async {
    SessionManager.instance.usersData = {};
  }

  Future<void> saveUserToken(String token) async {
    SessionManager.instance.authToken = token;
  }

  Future<void> savePasKey(String? key) async {
    SessionManager.instance.userPassKeySet = key;
  }
}
