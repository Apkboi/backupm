import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class GuidedPromptsItem extends StatelessWidget {
  const GuidedPromptsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
        context.pushNamed(PageUrl.createJournalScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Pallets.promptMilkCOlor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextView(
                    text: 'Gratitude and Joy',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Pallets.primary,
                  ),
                ),
                CircleAvatar(
                  foregroundColor: Pallets.primary,
                  backgroundColor: Pallets.white.withOpacity(0.5),
                  child: const Icon(
                    Icons.sync,
                    color: Pallets.primary,
                  ),
                )
              ],
            ),
            16.verticalSpace,
            const TextView(
              text:
                  'Explore a hobby or activity that brings you joy. Why do you enjoy it?',
              fontWeight: FontWeight.w600,
              color: Pallets.primary,
            ),
          ],
        ),
      ),
    );
  }
}
