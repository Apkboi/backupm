import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/create_session_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class NewSessionScheduledDialog extends StatelessWidget {
  const NewSessionScheduledDialog({
    super.key,
    required this.sessionDetails,
    this.tittle,
  });

  final SessionDetails sessionDetails;
  final String? tittle;

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
              color: Pallets.bottomSheetColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
            ),
          ),
          10.verticalSpace,
          TextView(
            text: tittle ?? 'Session scheduled!',
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
                ImageWidget(
                  imageUrl: sessionDetails.therapist.user.avatar,
                  size: 60,
                  borderRadius: BorderRadius.circular(50),
                ),
                10.verticalSpace,
                const TextView(
                  text: 'Session with',
                  align: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                10.verticalSpace,
                TextView(
                  text: sessionDetails.therapist.user.name,
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
                    TextView(
                      text: TimeUtil.formatToFullDate(
                          DateTime.parse(sessionDetails.startsAt)),
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
                    TextView(
                      text: TimeUtil.formatTime(
                        DateTime.parse(sessionDetails.startsAt),
                      ),
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
