import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class SubscriptionPromptDialog extends StatelessWidget {
  const SubscriptionPromptDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            color: Pallets.white, borderRadius: BorderRadius.circular(21)),
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
                text: 'Uppgrade',
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              22.verticalSpace,
              const TextView(
                text: therapySubscriptionMessage,
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
                color: Pallets.ink,
              ),
              20.verticalSpace,
              CustomNeumorphicButton(
                onTap: () {
                  context.pop(true);
                },
                color: Pallets.primary,
                text: "Upgrade",
              ),
              17.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
