import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/theme/pallets.dart';
class InputBar extends StatelessWidget {
  const InputBar({Key? key, required this.onAnswer, this.inputType})
      : super(key: key);
  final Function(String answer) onAnswer;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FilledTextField(
                hasBorder: false,
                hasElevation: false,
                inputType: inputType,
                suffix: InkWell(
                  onTap: () async {},
                  child: const Icon(
                    Icons.send_rounded,
                    size: 25,
                  ),
                ),
                fillColor: Pallets.white,
                contentPadding: const EdgeInsets.all(16),
                radius: 45,
                hint: 'Enter response'))
      ],
    );
  }
}