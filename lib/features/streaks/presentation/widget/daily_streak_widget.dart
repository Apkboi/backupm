import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class DailyStreakWidget extends StatefulWidget {
  const DailyStreakWidget({super.key});

  @override
  State<DailyStreakWidget> createState() => _DailyStreakWidgetState();
}

class _DailyStreakWidgetState extends State<DailyStreakWidget> {
  List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Pallets.streakBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.r)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: 'You’re on a 0-day streak!',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                14.verticalSpace,
                Row(
                  children: List.generate(
                      daysOfWeek.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              radius: 13,
                              foregroundColor: Pallets.black,
                              backgroundColor: Pallets.moodCheckerBg,
                              child: TextView(
                                text: daysOfWeek[index],
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )),
                )
              ],
            ),
          ),
          const Column(
            children: [
              // ImageWidget(imageUrl: Assets.images.pngs.streakBadge.path),
              // 3.verticalSpace,
              TextView(
                text: 'View badges',
                fontWeight: FontWeight.w700,
                fontSize: 14,
              )
            ],
          )
        ],
      ),
    );
  }
}
