// import 'package:fops/core/helpers/storage_helper.dart';
// import 'package:fops/core/helpers/storage_keys.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PinStorage {
//   static const _kUserTokenKey = StorageKeys.token;
//
//   PinStorage();
//
//   // Save pin to SharedPreferences
//   Future<void> saveUserPin(String pin) async {
//     StorageHelper.setString(StorageKeys.cachedUserPin, pin);
//   }
//
//   // Retrieve pin from SharedPreferences
//   Future<String?> getUserPin() async {
//     final pin = await StorageHelper.getString(StorageKeys.cachedUserPin);
//
//     return pin;
//   }
//
//   // Clear pin from SharedPreferences
//   Future<void> clearUserPin() async {
//     StorageHelper.remove(StorageKeys.cachedUserPin);
//   }
//
//   Future<void> saveUserToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_kUserTokenKey, token);
//   }
// }
