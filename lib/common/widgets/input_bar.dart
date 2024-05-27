import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class InputBar extends StatelessWidget {
  InputBar(
      {Key? key,
      required this.onAnswer,
      this.inputType,
      this.hint,
      this.validator,
      this.inputFormatters})
      : super(key: key);
  final Function(String answer) onAnswer;
  final TextInputType? inputType;
  final String? hint;
  final String? Function(String?)? validator;
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  final List<TextInputFormatter>? inputFormatters;

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

            fontSize: 17.sp,
              validator: validator,
              suffix: HapticInkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    onAnswer(controller.text);
                  }
                },
                child:  Icon(
                  Icons.send_rounded,
                  size: 25.w,
                ),
              ),
              fillColor: Pallets.white,
              inputFormatters: inputFormatters,
              contentPadding: const EdgeInsets.all(16),
              radius: 45.r,
              hint: hint ?? 'Enter response'),
        ))
      ],
    );
  }
}
