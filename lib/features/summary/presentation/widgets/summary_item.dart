import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/summary/presentation/widgets/summary_details_sheet.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomDialogs.showCupertinoBottomSheet(
            context, const SummaryDetailsSheet());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Pallets.summaryIndicator),
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Pallets.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextView(
                text: 'sssddd',
                color: Pallets.primary,
                fontWeight: FontWeight.w600,
              ),
              8.verticalSpace,
              const TextView(
                text: '2021-12-13 13:43',
                fontWeight: FontWeight.w700,
              ),
              16.verticalSpace,
              const TextView(
                fontSize: 13,
                text:
                    'Recap: Strategies for managing stress, mindfulness techniques. See suggestions and resources.',
                fontWeight: FontWeight.w500,
                color: Pallets.ink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
