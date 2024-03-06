import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/input_bar.dart';

class BcUserEmailField extends StatefulWidget {
  const BcUserEmailField({super.key});

  @override
  State<BcUserEmailField> createState() => _BcUserEmailFieldState();
}

class _BcUserEmailFieldState extends State<BcUserEmailField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      onAnswer: (answer) {},
    );
  }
}
