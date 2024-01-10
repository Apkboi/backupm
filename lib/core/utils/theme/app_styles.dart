import 'package:flutter/material.dart';

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
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade50.withOpacity(0.5), width: 4),
      boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, 10), blurRadius: 7)
      ]);
}
