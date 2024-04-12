import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';
import 'package:mentra/features/tasks/presentation/widget/daily_task_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';

class DailyTaskTab extends StatefulWidget {
  const DailyTaskTab({super.key});

  @override
  State<DailyTaskTab> createState() => _DailyTaskTabState();
}

class _DailyTaskTabState extends State<DailyTaskTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 100.verticalSpace,

        Expanded(
          child: BlocConsumer<DailyTaskBloc, DailyTaskState>(
            bloc: injector.get<DailyTaskBloc>(),
            listener: _listenToDailyTaskBloc,
            builder: (context, state) {
              var dailyTasks = injector.get<DailyTaskBloc>().dailyTasks;
              if (state is GetDailyTaskLoadingState) {
                return Center(child: CustomDialogs.getLoading(size: 30));
              }

              if (state is GetDailyTaskFailureState) {
                return AppPromptWidget(
                  onTap: () {
                    injector.get<DailyTaskBloc>().add(GetDailyTaskEvent());
                  },
                  message: state.error,
                  title: 'Ooops!',
                );
              }

              if (dailyTasks.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    injector.get<DailyTaskBloc>().add(GetDailyTaskEvent());
                  },
                  child: ListView.builder(
                    itemCount: dailyTasks.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DailyTaskItem(
                        task: dailyTasks[index],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: const [
                      AppEmptyState(
                        tittle: 'No Tasks',
                        subtittle: '',
                        hasBg: false,
                      ),
                      // Spacer(),
                    ],
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }

  void _listenToDailyTaskBloc(BuildContext context, DailyTaskState state) {}
}
