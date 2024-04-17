import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';

class EndTherapySessionDialog extends StatelessWidget {
  const EndTherapySessionDialog({Key? key, required this.session})
      : super(key: key);
  final TherapySession session;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Pallets.bottomSheetColor,
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
            19.verticalSpace,
            TextView(
              text: 'Are you sure you want to end\nthe session now?',
              align: TextAlign.center,
              style: GoogleFonts.fraunces(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            22.verticalSpace,
            Row(
              children: [
                TextView(
                  text: 'Duration: ${session.duration}minutes',
                  color: Pallets.ink,
                )
              ],
            ),
            8.verticalSpace,
            const TextView(
              text: endTherapySessionMessage,
              align: TextAlign.start,
              fontWeight: FontWeight.w500,
              color: Pallets.ink,
            ),
            20.verticalSpace,
            CustomNeumorphicButton(
              onTap: () {
                context.pop(true);
              },
              color: Pallets.primary,
              text: "End Session",
            ),
            17.verticalSpace,
            CustomNeumorphicButton(
              onTap: () {
                context.pop();
              },
              color: Pallets.buttonBlack,
              text: "Go back",
            ),
            17.verticalSpace,
          ],
        ),
      ),
    );
  }
}
