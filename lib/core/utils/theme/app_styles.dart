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

}