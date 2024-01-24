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

  static BoxDecoration customFilledTextFieldBoxDecoration =  BoxDecoration(
      color: Pallets.white,
      borderRadius: BorderRadius.circular(17));

  static ShapeDecoration customBorderedTextFieldBoxDecoration = ShapeDecoration(
      color: Pallets.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
              color: Colors.grey.withOpacity(
                0.3,
              ),
              width: 0.8)));
}
