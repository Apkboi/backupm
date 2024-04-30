import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class UpcomingSessionsWidget extends StatefulWidget {
  const UpcomingSessionsWidget({super.key, required this.session});

  final TherapySession session;

  @override
  State<UpcomingSessionsWidget> createState() => _UpcomingSessionsWidgetState();
}

class _UpcomingSessionsWidgetState extends State<UpcomingSessionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          color: Pallets.dailyTaskBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const _Indicator(),
            // 17.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextView(
                    text: 'Session with ${widget.session.therapist.user.name}.',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.icCalender),
                      5.horizontalSpace,
                      TextView(
                        text: TimeUtil.formartToDayTime(
                            widget.session.startsAt.toLocal()),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.icClock),
                      5.horizontalSpace,
                      TextView(
                        text:
                            '${TimeUtil.formatTime(widget.session.startsAt.toLocal())} - ${TimeUtil.formatTime(widget.session.startsAt.add(const Duration(hours: 1)))}',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ],
                  ),
                  // 10.verticalSpace
                ],
              ),
            ),
            Column(
              children: [
                ImageWidget(
                  imageUrl: widget.session.user.avatar,
                  shape: BoxShape.circle,
                  size: 50,
                ),
                5.verticalSpace,
                CustomNeumorphicButton(
                    padding: const EdgeInsets.all(6),
                    expanded: false,
                    fgColor: Pallets.black,
                    onTap: () {},
                    text: 'Chat',
                    color: Pallets.secondary),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 4,
        // height: 64.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(37), color: Pallets.primary));
  }
}
