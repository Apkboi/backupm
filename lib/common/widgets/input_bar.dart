import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/theme/pallets.dart';

class InputBar extends StatelessWidget {
   InputBar(
      {Key? key,
      required this.onAnswer,
      this.inputType,
      this.hint,
      this.validator})
      : super(key: key);
  final Function(String answer) onAnswer;
  final TextInputType? inputType;
  final String? hint;
  final String? Function(String?)? validator;
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Form(
          key: _formKey,
          child: FilledTextField(
              hasBorder: false,
              hasElevation: false,
              inputType: inputType,
              controller: controller,
              validator: validator,
              suffix: InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    onAnswer(controller.text);
                  }
                },
                child: const Icon(
                  Icons.send_rounded,
                  size: 25,
                ),
              ),
              fillColor: Pallets.white,
              contentPadding: const EdgeInsets.all(16),
              radius: 45,
              hint: hint ?? 'Enter response'),
        ))
      ],
    );
  }
}