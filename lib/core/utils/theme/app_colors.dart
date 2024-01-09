import 'package:flutter/material.dart';

const secondaryColor = Color(0xFF0E0B0A);
const Color appPrimaryColor = Color(0xff324ce1);
Color lightBackgroundColor = Colors.white;
const Color darkBackgroundColor = Color(0xFF15171b);
const Color darkCardColor = Color(0xFF21242a);
const Color lightCardColor = Color(0xF7E1DBDB);
const Color darkGrey = Color(0xFFA4A4A4);
Color lightGrey = Colors.grey.shade300;
const Color secondaryGoldColor = Color(0xFFE7AC63);
const Color primaryColorLight = Color(0x99F05E5E);
const Color primaryColorDark = Color(0xFF343434);
const Color redColor = Color(0xFFFF0101);
Color inputColorLight = Colors.grey.shade200.withOpacity(0.5);
const Color inputColorDark = Color(0xFF211E1E);
const Color uploadButtonColor = Color(0xFFD7D7D7);
const Color darkBottomSheetColor = Color(0xFF252836);
const Color lightBottomSheetColor = Colors.white;
const Color white = Colors.white;
const smokeWhite = Color(0xFFf1f7f8);
const Color black = Colors.black;
const red = Color(0xFFff0000);
const Color gold = Color(0xFFcfa23c);
const textColor = Color(0xFF5f6368);

extension ColorSchemeEx on ColorScheme {
  Color get backgroundColor => brightness == Brightness.dark
      ? darkBackgroundColor
      : lightBackgroundColor;

  Color get toolbarColor => brightness == Brightness.dark
      ? darkBackgroundColor
      : lightBackgroundColor;
}
