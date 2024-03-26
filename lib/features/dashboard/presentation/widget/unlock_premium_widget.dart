import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_item.dart';

class UnlockPremiumWidget extends StatelessWidget {
  const UnlockPremiumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const TherapyStatusIndicator(),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: 'Exclusive Therapist Access',
                    style: GoogleFonts.fraunces(
                        fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  8.verticalSpace,
                  const TextView(
                    text: 'Unlock premium features now:',
                    color: Pallets.ink,
                  ),
                  8.verticalSpace,
                  ...List.generate(
                      3,
                      (index) => const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: _PremiumFeature(),
                          )),
                  10.verticalSpace,
                  CustomNeumorphicButton(
                      expanded: true,
                      text: 'Unlock Premium',
                      fgColor: Pallets.navy,
                      padding: const EdgeInsets.all(10),
                      onTap: () {
                        context.pushNamed(PageUrl.selectPlanScreen);
                      },
                      color: Pallets.secondary)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumFeature extends StatelessWidget {
  const _PremiumFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.circle,
          size: 6,
        ),
        8.horizontalSpace,
        const Expanded(
          child: TextView(
            text: 'Direct messaging for ongoing support',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
