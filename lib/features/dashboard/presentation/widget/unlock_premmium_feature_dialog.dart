import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class UnlockPremiumFeatureDialog extends StatelessWidget {
  const UnlockPremiumFeatureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Container(
        decoration: BoxDecoration(
            color: Pallets.white, borderRadius: BorderRadius.circular(25)),
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
              37.verticalSpace,
              ImageWidget(
                imageUrl: Assets.images.svgs.success,
              ),
              10.verticalSpace,
              TextView(
                text: "🔐 Unlock Premium Features",
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              20.verticalSpace,
              const TextView(
                text: newFeatureMessage,
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              37.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNeumorphicButton(
                    expanded: false,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 16),
                    onTap: () {
                      context.pop();
                      context.pushNamed(PageUrl.selectPlanScreen);
                    },
                    color: Pallets.primary,
                    text: "Explore Plans",
                  ),
                ],
              ),
              17.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
