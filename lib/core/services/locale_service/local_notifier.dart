// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class LocaleNotifier extends ChangeNotifier {
//   Locale _locale;
//   LocaleNotifier(this._locale);
//
//   Locale get locale => _locale;
//
//   void setLocale(Locale locale) {
//     if (_locale != locale) {
//       _locale = locale;
//       notifyListeners();
//     }
//   }
// }
//
// final localeProvider = ChangeNotifierProvider<LocaleNotifier>(
//   (ref) => LocaleNotifier(const Locale('en', 'US')),
// );
