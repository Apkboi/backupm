import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/input_bar.dart';

class BCEmailPreviewField extends StatefulWidget {
  const BCEmailPreviewField({super.key});

  @override
  State<BCEmailPreviewField> createState() => _BCEmailPreviewFieldState();
}

class _BCEmailPreviewFieldState extends State<BCEmailPreviewField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      onAnswer: (answer) {},
    );
  }
}
