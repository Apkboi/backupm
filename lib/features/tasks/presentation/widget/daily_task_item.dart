import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/extensions/context_extension.dart';
import 'package:mentra/features/tasks/data/models/get_daily_task_response.dart';
import 'package:mentra/features/tasks/presentation/widget/task_check_button.dart';

class DailyTaskItem extends StatefulWidget {
  const DailyTaskItem({super.key, required this.task});

  final DailyTaskModel task;

  @override
  State<DailyTaskItem> createState() => _DailyTaskItemState();
}

class _DailyTaskItemState extends State<DailyTaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Pallets.dailyTaskItemBg),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextView(
                  text: widget.task.title,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              TaskCheckButton(
                  done: widget.task.hasDoneTask, id: widget.task.id.toString())
            ],
          ),
          8.verticalSpace,
          RichText(
              text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(
                    color: context.colorScheme.onBackground,
                    fontSize: 12.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                TextSpan(
                    text: 'Task: ',
                    style: GoogleFonts.plusJakartaSans(
                      color: Pallets.darkGold,
                      fontSize: 12.sp,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    )),
                TextSpan(text: widget.task.task)
              ])),
          8.verticalSpace,
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 11.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r), color: Pallets.gold),
            child: TextView(
              text: widget.task.subText,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
