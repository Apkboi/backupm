import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/input_bar.dart';
class BcSelectYearField extends StatefulWidget {
  const BcSelectYearField({super.key});

  @override
  State<BcSelectYearField> createState() => _BcSelectYearFieldState();
}

class _BcSelectYearFieldState extends State<BcSelectYearField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      onAnswer: (answer) {},
    );
  }
}
