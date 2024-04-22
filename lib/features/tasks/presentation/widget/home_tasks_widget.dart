import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';

class HomeTasksWidget extends StatefulWidget {
  const HomeTasksWidget({super.key});

  @override
  State<HomeTasksWidget> createState() => _HomeTasksWidgetState();
}

class _HomeTasksWidgetState extends State<HomeTasksWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyTaskBloc, DailyTaskState>(
      bloc: injector.get<DailyTaskBloc>(),
      listener: _listenToDailyBlocState,
      builder: (context, state) {
        var dailyTasks = injector.get<DailyTaskBloc>().dailyTasks;
        if (dailyTasks != null) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
                color: Pallets.dailyTaskBg.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.r)),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // const _Indicator(),
                  // 17.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: 'Daily Task',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        // 8.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                                child: TextView(
                              text: dailyTasks?.title ?? "",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            )),
                            CustomNeumorphicButton(
                                padding: const EdgeInsets.all(6),
                                expanded: false,
                                fgColor: Pallets.black,
                                onTap: () {
                                  context.pushNamed(PageUrl.summariesScreen);
                                },
                                // text: 'Try this',
                                color: Pallets.secondary,
                                child: const TextView(
                                  text: 'Try this',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ))
                          ],
                        ),
                        // 10.verticalSpace
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            width: 1.sw,
            height: 85.h,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Pallets.dailyTaskBg.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.r)),
            child: const Center(
                child: TextView(
              text: 'You have no daily task assigned to you',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
          );
          //
        }
      },
    );
  }

  void _listenToDailyBlocState(BuildContext context, DailyTaskState state) {}
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
