import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final sessionProvider = Provider<SessionManager>((ref) {
//   SessionManager().init();
//   final sessionManager = SessionManager.instance;
//   return sessionManager;
// });

/// A class for managing sessions, handles saving and retrieving of data
class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;
  FlutterSecureStorage? secureStorage;

  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    secureStorage = const FlutterSecureStorage();
  }

  static const String KEY_USERS_DATA = 'usersData';
  static const String KEY_AUTH_TOKEN = 'authToken';
  static const String KEY_USE_BIO = 'useBiometrics';
  static const String KEY_AUTH_PASS = 'password_koey';
  static const String KEY_BALANCE = 'balance';
  static const String HAS_ONBOARDED = 'has_onboarded';
  static const String KEY_IS_LOGIN = 'is_logged_in';
  static const String BIOMETRIC_ENABLED = 'biometric_enabled';
  static const String IS_CONTACT_PERMITTED = 'permit_contact';
  static const String KEY_USER_EMAIL = 'logged_in_user_email';

  Map get usersData =>
      json.decode(sharedPreferences!.getString(KEY_USERS_DATA) ?? '');

  set usersData(Map map) =>
      sharedPreferences!.setString(KEY_USERS_DATA, json.encode(map));

  bool doesUserDataExists() {
    return sharedPreferences!.containsKey(KEY_AUTH_TOKEN);
  }

  set arrivedHome(bool allowed) {
    sharedPreferences!.setBool(IS_CONTACT_PERMITTED, allowed);
  }

  bool get arrivedHome =>
      sharedPreferences!.getBool(IS_CONTACT_PERMITTED) ?? false;

  bool get useBio => sharedPreferences!.getBool(KEY_USE_BIO) ?? false;

  String get authToken => sharedPreferences!.getString(KEY_AUTH_TOKEN) ?? '';

  String get userEmail => sharedPreferences!.getString(KEY_USER_EMAIL) ?? '';

  Future<String?>? get userPassKeyGet async =>
      await secureStorage?.read(key: KEY_AUTH_PASS);

  // Future<String> getUserPassKey() async =>
  //     await secureStorage?.read(key: KEY_AUTH_PASS) ?? '';

  set authToken(String authToken) =>
      sharedPreferences!.setString(KEY_AUTH_TOKEN, authToken);

  set useBio(bool useBio) => sharedPreferences!.setBool(KEY_USE_BIO, useBio);

  set userEmail(String userEmail) =>
      sharedPreferences!.setString(KEY_USER_EMAIL, userEmail);

  set userPassKeySet(String? userPassKey) =>
      secureStorage?.write(key: KEY_AUTH_PASS, value: userPassKey);

  String get balance => sharedPreferences!.getString(KEY_BALANCE) ?? '';

  set balance(String balance) =>
      sharedPreferences!.setString(KEY_BALANCE, balance);

  set isLoggedIn(bool loggedIn) {
    sharedPreferences!.setBool(KEY_IS_LOGIN, loggedIn);
  }

  set hasOnboarded(bool loggedIn) {
    sharedPreferences!.setBool(HAS_ONBOARDED, loggedIn);
  }

  set bioMetricEnabled(bool loggedIn) {
    sharedPreferences!.setBool(BIOMETRIC_ENABLED, loggedIn);
  }

  bool get bioMetricEnabled =>
      sharedPreferences!.getBool(BIOMETRIC_ENABLED) ?? false;

  bool get isLoggedIn => sharedPreferences!.getBool(KEY_IS_LOGIN) ?? false;

  bool get hasOnboarded => sharedPreferences!.getBool(HAS_ONBOARDED) ?? false;

  Future<bool> logOut() async {
    // final holdEmail = sharedPreferences?.getString(KEY_USER_EMAIL);
    // final holdPass = sharedPreferences?.getString(KEY_BALANCE);
    // final holdUseBio = sharedPreferences?.getBool(KEY_USE_BIO);
    //
    // await sharedPreferences!.clear();
    //
    // sharedPreferences?.setString(KEY_USER_EMAIL, holdEmail ?? '');
    // sharedPreferences?.setString(KEY_BALANCE, holdPass ?? '');
    // sharedPreferences?.setBool(KEY_USE_BIO, holdUseBio ?? false);

    instance.isLoggedIn = false;
    // await secureStorage?.deleteAll();
    // await sharedPreferences?.clear();
    // await HiveBoxes.clearAllBox();
    // try {
    //   DefaultCacheManager().emptyCache();
    // } catch (e) {
    //   logger.e(e);
    // }
    return true;
  }
}
