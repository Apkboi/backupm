import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class ConfirmDeleteSummarySheet extends StatelessWidget {
  const ConfirmDeleteSummarySheet({Key? key}) : super(key: key);

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
              text: 'Are you sure you want to delete this the session summary?',
              align: TextAlign.center,
              style: GoogleFonts.fraunces(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            22.verticalSpace,
            const TextView(
              text:
                  "Once deleted, this information cannot be recovered. Please confirm your decision.",
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: Pallets.ink,
            ),
            20.verticalSpace,
            CustomNeumorphicButton(
              onTap: () async {
                await CustomDialogs.showBottomSheet(
                    context,
                    SuccessDialog(
                      tittle:
                          'The session summary has been successfully deleted.',
                      onClose: () {
                        context.pop();
                        context.pop();
                        context.pop();
                      },
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                    constraints: BoxConstraints(maxHeight: 0.9.sh));
              },
              color: Pallets.red,
              text: "Yes, I want to delete it.",
            ),
            17.verticalSpace,
            CustomNeumorphicButton(
              onTap: () {},
              color: Pallets.primary,
              text: "No, keep it.",
            ),
            17.verticalSpace,
          ],
        ),
      ),
    );
  }
}
