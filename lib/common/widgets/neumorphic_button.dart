import 'package:flutter/material.dart';
import 'package:mentra/core/utils/theme/app_styles.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

class CustomNeumorphicButton extends StatelessWidget {
  const CustomNeumorphicButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: AppStyles.cardDecoration,
      child: const Text(
        'Press me',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
