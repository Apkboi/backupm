import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class WorkSheetDetailItem extends StatefulWidget {
  const WorkSheetDetailItem({super.key});

  @override
  State<WorkSheetDetailItem> createState() => _WorkSheetDetailItemState();
}

class _WorkSheetDetailItemState extends State<WorkSheetDetailItem> {
  bool isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HapticInkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Pallets.grey,
                ),
                6.horizontalSpace,
                const TextView(
                  text: "Morning",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                6.horizontalSpace,
                const TextView(
                  text: "(2)",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Pallets.grey,
                ),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        AnimatedCrossFade(
            firstChild: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Pallets.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: List.generate(3, (index) => const _TaskItem()),
              ),
            ),
            secondChild: 0.verticalSpace,
            crossFadeState:
                isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300)),
      ],
    );
  }
}

class _TaskItem extends StatefulWidget {
  const _TaskItem({
    super.key,
  });

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                isChecked = value;
              });
            }
          },
          activeColor: Pallets.primary,
        ),
        // 3.horizontalSpace,
        TextView(
          text: "Hello",
          color: isChecked ? Pallets.primary : Pallets.grey,
          fontWeight: FontWeight.w600,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        )
      ],
    );
  }
}
