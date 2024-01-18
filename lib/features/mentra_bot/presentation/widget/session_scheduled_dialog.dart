import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class SessionScheduledDialog extends StatelessWidget {
  const SessionScheduledDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      width: 1.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            text: 'Session Scheduled!',
            align: TextAlign.center,
            style: GoogleFonts.fraunces(
                fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          16.verticalSpace,
          Container(
            decoration: BoxDecoration(
                color: Pallets.bottomSheetColor,
                borderRadius: BorderRadius.circular(17)),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ImageWidget(imageUrl: Assets.images.svgs.avatar1),
                10.verticalSpace,
                const TextView(
                  text: 'Session with',
                  align: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                10.verticalSpace,
                const TextView(
                  text: 'Nour Martin, Ph.D.',
                  align: TextAlign.center,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Pallets.primary,
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageWidget(imageUrl: Assets.images.svgs.icCalender),
                    10.horizontalSpace,
                    const TextView(
                      text: ' Saturday, 02 December 2023',
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageWidget(imageUrl: Assets.images.svgs.icClock),
                    10.horizontalSpace,
                    const TextView(
                      text: ' 9:00 am',
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
          16.verticalSpace,
          CustomNeumorphicButton(
            onTap: () {
              context.pop();
            },
            color: Pallets.primary,
            text: 'Done',
          )
        ],
      ),
    );
  }
}
