import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';

class TaskCheckButton extends StatefulWidget {
  const TaskCheckButton({super.key, required this.done, required this.id});

  final bool done;
  final String id;

  @override
  State<TaskCheckButton> createState() => _TaskCheckButtonState();
}

class _TaskCheckButtonState extends State<TaskCheckButton> {
  late bool isDone;

  final taskBloc = DailyTaskBloc(injector.get());

  @override
  void initState() {
    isDone = widget.done;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyTaskBloc, DailyTaskState>(
      bloc: taskBloc,
      listener: (context, state) {
        if (state is UpdateDailyTaskSuccessState) {
          isDone = state.response.data.hasDoneTask;
          injector.get<DailyTaskBloc>().add(GetDailyTaskEvent());
          // injector
          //     .get<WellnessLibraryBloc>()
          //     .add(const GetFavouriteCoursesEvent());
          CustomDialogs.success('Task updated');
          setState(() {});
        }
        if (state is UpdateDailyTaskFailureState) {
          CustomDialogs.error(state.error);
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            taskBloc.add(UpdateDailyTaskEvent(widget.id));
          },
          child: state is UpdateDailyTaskLoadingState
              ? CustomDialogs.getLoading(size: 7, color: Pallets.darkGold)
              : Icon(
                  Icons.check_circle,
                  color: isDone ? Pallets.darkGold : Pallets.grey75,
                  size: 20,
                ),
        );
      },
    );
  }
}
