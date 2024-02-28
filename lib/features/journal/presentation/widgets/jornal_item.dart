import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class JournalItem extends StatelessWidget {
  const JournalItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Pallets.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextView(
                text: 'February 11, 2024 - 10:30 PM',
                fontSize: 13.sp,
              )),
              InkWell(onTap: () {}, child: const Icon(Icons.more_vert))
            ],
          ),
          16.verticalSpace,
          const _PromptWidget()
        ],
      ),
    );
  }
}

class _PromptWidget extends StatelessWidget {
  const _PromptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Pallets.promptMilkCOlor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: 'Gratitude and Joy',
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Pallets.navy,
          ),
          16.verticalSpace,
          TextView(
            text:
                'Explore a hobby or activity that brings you joy. Why do you enjoy it?',
            fontWeight: FontWeight.w600,
            color: Pallets.navy,
          ),
        ],
      ),
    );
  }
}
