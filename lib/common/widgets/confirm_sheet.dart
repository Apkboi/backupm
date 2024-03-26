import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class ConfirmSheet extends StatelessWidget {
  const ConfirmSheet(
      {Key? key,
      this.tittle,
      this.subtittle,
      this.confirmText,
      this.cancelText,
      this.confirmButtonColor,
      this.cancelButtonColor,
      required this.onConfirm,
      required this.onCancel})
      : super(key: key);
  final String? tittle;
  final String? subtittle;
  final String? confirmText;
  final String? cancelText;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Pallets.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(21), topLeft: Radius.circular(21))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 49,
              height: 5,
              decoration: ShapeDecoration(
                color: const Color(0xFFBCC4CC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
            ),
            10.verticalSpace,
            TextView(
              text: tittle ?? 'Are you sure ?',
              align: TextAlign.center,
              style: GoogleFonts.fraunces(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            22.verticalSpace,
            TextView(
              text: subtittle ??
                  "Once deleted, this information cannot be recovered. Please confirm your decision.",
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: Pallets.ink,
            ),
            20.verticalSpace,
            CustomNeumorphicButton(
              onTap: onCancel,
              color: cancelButtonColor ?? Pallets.primary,
              text: cancelText ?? "No, keep it.",
            ),
            17.verticalSpace,
            CustomNeumorphicButton(
              onTap: onConfirm,
              color: confirmButtonColor ?? Pallets.red,
              text: confirmText ?? "Yes, I want to delete it.",
            ),
            17.verticalSpace,
          ],
        ),
      ),
    );
  }
}
