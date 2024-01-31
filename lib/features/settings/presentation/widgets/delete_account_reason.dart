import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class DeleteAccountReason extends StatelessWidget {
  const DeleteAccountReason({super.key, required this.onDelete});

  final VoidCallback onDelete;

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
              text: "Why did you decide to leave Mentra?",
              align: TextAlign.center,
              style: GoogleFonts.fraunces(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            22.verticalSpace,
            const TextView(
              text:
                  "Before you go, could you share the reason for deleting your account? Your insights matter to us.",
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: Pallets.ink,
            ),
            20.verticalSpace,
            const AppFilledTextField(
              hint: 'Not Selected',
              label: "Please tell us more",
              maxLines: 5,
            ),
            20.verticalSpace,
            CustomNeumorphicButton(
              onTap: () {
                onDelete();
              },
              color: Pallets.red,
              text: "Yes, I want to delete it.",
            ),
            17.verticalSpace,
          ],
        ),
      ),
    );
  }
}