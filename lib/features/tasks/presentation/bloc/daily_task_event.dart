part of 'daily_task_bloc.dart';

abstract class DailyTaskEvent extends Equatable {
  const DailyTaskEvent();
}

class GetDailyTaskEvent extends DailyTaskEvent {
  @override
  List<Object?> get props => [];
}

class UpdateDailyTaskEvent extends DailyTaskEvent {
  final String taskId;

  const UpdateDailyTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
