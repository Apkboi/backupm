part of 'daily_task_bloc.dart';

abstract class DailyTaskState extends Equatable {
  const DailyTaskState();
}

class DailyTaskInitial extends DailyTaskState {
  @override
  List<Object> get props => [];
}

class GetDailyTaskLoadingState extends DailyTaskState {
  @override
  List<Object> get props => [];
}

class GetDailyTaskSuccessState extends DailyTaskState {
  final dynamic response;

  const GetDailyTaskSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetDailyTaskFailureState extends DailyTaskState {
  final String error;

  const GetDailyTaskFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class UpdateDailyTaskLoadingState extends DailyTaskState {
  @override
  List<Object> get props => [];
}

class UpdateDailyTaskSuccessState extends DailyTaskState {
  final UpdateDailyTaskResponse response;

  const UpdateDailyTaskSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class UpdateDailyTaskFailureState extends DailyTaskState {
  final String error;

  const UpdateDailyTaskFailureState(this.error);

  @override
  List<Object> get props => [error];
}
