import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/models/day_of_week.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';
import 'package:mentra/features/work_sheet/presentation/blocs/worksheet/worksheet_bloc.dart';

class WorkSheetDetailItem extends StatefulWidget {
  const WorkSheetDetailItem(
      {super.key, required this.weeklyTask, required this.period});

  final List<WeeklyTodoTask> weeklyTask;
  final String period;

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
                 Icon(
                  Icons.keyboard_arrow_down,
                  color: Pallets.grey,
                  size: 18.w,
                ),
                6.horizontalSpace,
                TextView(
                  text: widget.period,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                6.horizontalSpace,
                TextView(
                  text: "(${widget.weeklyTask.length})",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Pallets.grey,
                ),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedCrossFade(
              firstChild: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Pallets.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: List.generate(
                      widget.weeklyTask.length,
                      (index) => Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.0.h),
                        child: _TaskItem(
                              task: widget.weeklyTask[index],
                              currentDay: context
                                  .watch<WorkSheetBloc>()
                                  .selectedDay,
                            ),
                      )),
                ),
              ),
              secondChild: 0.verticalSpace,
              crossFadeState: isOpen && widget.weeklyTask.isNotEmpty
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300)),
        ),
      ],
    );
  }
}

class _TaskItem extends StatefulWidget {
  _TaskItem({
    super.key,
    required this.task,
    required this.currentDay,
  });

  WeeklyTodoTask task;
  final DayOfWeek currentDay;

  @override
  State<_TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<_TaskItem> {
  bool isChecked = true;
  final bloc = WorkSheetBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkSheetBloc, WorkSheetState>(
      bloc: bloc,
      listener: _listenToWorkSheetBloc,
      child: InkWell(
        onTap: () {

          // if(){}

          bloc.add(MarkTaskEvent(widget.task.id.toString()));
        },
        child: Row(
          children: [
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Checkbox(

                value: widget.task.completed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
                onChanged: (value) {
                  bloc.add(MarkTaskEvent(widget.task.id.toString()));

                  // if (value != null) {}
                },
                activeColor: Pallets.primary,
              ),
            ),
            // 3.horizontalSpace,
            TextView(
              text: widget.task.task,
              color: widget.task.completed ? Pallets.primary : Pallets.grey,
              fontWeight: FontWeight.w600,
              decoration:
                  widget.task.completed ? TextDecoration.lineThrough : null,
            )
          ],
        ),
      ),
    );
  }

  void _listenToWorkSheetBloc(BuildContext context, WorkSheetState state) {
    if (state is WorkSheetLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is MarkTaskSuccessState) {
      context.pop();

      setState(() {
        widget.task.completed = !widget.task.completed;
      });
      CustomDialogs.success("Task updated");
    }
    if (state is WorkSheetFailureState) {
      context.pop();

      CustomDialogs.error(state.error);
    }
  }
}
