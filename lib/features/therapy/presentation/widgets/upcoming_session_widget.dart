import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class UpcomingSessionsWidget extends StatefulWidget {
  const UpcomingSessionsWidget({super.key});

  @override
  State<UpcomingSessionsWidget> createState() => _UpcomingSessionsWidgetState();
}

class _UpcomingSessionsWidgetState extends State<UpcomingSessionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
          color: Pallets.dailyTaskBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _Indicator(),
            17.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextView(
                    text: 'Session with Laila Abbas',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.icCalender),
                      5.horizontalSpace,
                      const TextView(
                        text: 'Sunday, 12 June',
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

                      const TextView(
                        text: '11:00 - 12:00 AM',
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
                  imageUrl: Assets.images.pngs.avatar1.path,
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
