import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/core/theme/pallets.dart';

class AppTheme extends ChangeNotifier {
  ThemeData get selectedTheme => _selectedTheme;
  ThemeData _selectedTheme = lightTheme;

  TextTheme get selectedTextTheme => _selectedTheme.textTheme;

  void toggleTheme() {
    _selectedTheme = _selectedTheme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Pallets.primary,
    hintColor: Pallets.grey,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    appBarTheme: const AppBarTheme(
      color: Pallets.white,
      iconTheme: IconThemeData(
        color: Pallets.primary,
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
        size: 24,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 96.0.sp, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 60.0.sp, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 48.0.sp, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 34.0.sp, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 20.0.sp, fontWeight: FontWeight.w600, height: 1.5),
      titleMedium: TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.normal),
      titleSmall: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontSize: 16.0.sp),
      bodyMedium: TextStyle(fontSize: 14.0.sp),
      bodySmall: TextStyle(fontSize: 12.sp),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Pallets.primary,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    iconTheme: const IconThemeData(color: Pallets.primary),
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.only(
        bottom: 16,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
    colorScheme: ColorScheme(
      background: Colors.white,
      brightness: Brightness.light,
      primary: Pallets.primary,
      secondary: Colors.blueAccent,
      error: Colors.red,
      onBackground: Colors.black,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      surface: Colors.grey[200]!,
    ),
  );

  static final ThemeData darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
    primaryColor: Pallets.primary,
    hintColor: Colors.lightBlueAccent,
    scaffoldBackgroundColor: Pallets.bgDark,
    appBarTheme: const AppBarTheme(
      color: Pallets.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    textTheme: lightTheme.textTheme.apply(bodyColor: Colors.white70),
    iconTheme: const IconThemeData(color: Colors.white70),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueGrey,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: lightTheme.inputDecorationTheme,
    colorScheme: lightTheme.colorScheme
        .copyWith(background: Colors.grey[900], onBackground: Pallets.white),
  );
}

// final themeProvider = ChangeNotifierProvider<AppTheme>((ref) {
//   return AppTheme();
// });
