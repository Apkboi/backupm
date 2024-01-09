import 'dart:ui';

import 'package:flutter/material.dart';

class PowerText extends StatelessWidget {
  final String base;
  final String exponent;
  final TextStyle? baseTextStyle;
  final TextStyle? exponentTextStyle;
  final TextStyle? style;

  PowerText(
      {required this.base,
      required this.exponent,
      this.baseTextStyle,
      this.exponentTextStyle,
      this.style});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: base,
        style:
            baseTextStyle ?? const TextStyle(fontSize: 14, color: Colors.black),
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0.0, -4.0),
              child: Text(
                exponent,
                style: exponentTextStyle ??
                    const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        textBaseline: TextBaseline.alphabetic),
              ),
            ),
          ),
          // TextSpan(
          //   text: exponent,
          //   style: exponentTextStyle ??
          //       const TextStyle(
          //           fontSize: 12,
          //           color: Colors.black,
          //
          //           textBaseline: TextBaseline.alphabetic),
          // ),
        ],
      ),
    );
  }
}
