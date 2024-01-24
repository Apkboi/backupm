import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/app_styles.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'filled_textfield.dart';

class AppFilledTextField extends StatelessWidget {
  const AppFilledTextField(
      {super.key,
      this.label,
      required this.hint,
      this.decoration,
      this.controller,
      this.labelWidget,
      this.obscured = false,
      this.suffix,
      this.enabled = true,
      this.maxLines});

  final String? label;
  final Widget? labelWidget;
  final String hint;
  final Decoration? decoration;
  final TextEditingController? controller;
  final bool? obscured;
  final Widget? suffix;
  final bool enabled;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: enabled
          ? AppStyles.customBorderedTextFieldBoxDecoration
          : AppStyles.customFilledTextFieldBoxDecoration
              .copyWith(color: Pallets.grey200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWidget ??
              TextView(
                text: label ?? '',
                style: GoogleFonts.inter(
                    color: enabled ? null : Pallets.grey,
                    fontSize: 12,
                    fontWeight: enabled ? FontWeight.w500 : FontWeight.normal),
              ),
          5.verticalSpace,
          FilledTextField(
              hasElevation: false,
              contentPadding: EdgeInsets.zero,
              hasBorder: false,
              enabled: enabled,
              fillColor: Colors.transparent,
              suffix: suffix,
              maxLine: maxLines,
              obscured: obscured,
              hint: hint),
        ],
      ),
    );
  }
}
