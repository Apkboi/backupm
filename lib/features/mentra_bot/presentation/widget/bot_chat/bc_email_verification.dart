import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/input_bar.dart';

class BCEmailVerificationField extends StatefulWidget {
  const BCEmailVerificationField({super.key});

  @override
  State<BCEmailVerificationField> createState() =>
      _BCEmailVerificationFieldState();
}

class _BCEmailVerificationFieldState extends State<BCEmailVerificationField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      onAnswer: (answer) {},
    );
  }
}
