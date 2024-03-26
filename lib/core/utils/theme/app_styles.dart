import 'package:flutter/material.dart';
import 'package:mentra/core/theme/pallets.dart';

class AppStyles {
  static InputDecoration filledTextFieldDecoration = InputDecoration(
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
    border: OutlineInputBorder(
        gapPadding: 2,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
      color: Pallets.navy,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Pallets.primary, width: 2),
      boxShadow: const [
        BoxShadow(
            color: Color(0xFF242628),
            offset: Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1),
        BoxShadow(
            color: Color(0xFF242628),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0),
      ]);
}
