import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/tasks/data/models/get_daily_task_response.dart';
import 'package:mentra/features/tasks/data/models/update_daily_task_response.dart';
import 'package:mentra/features/tasks/domain/repository/daily_task_repository.dart';

part 'daily_task_event.dart';

part 'daily_task_state.dart';

class DailyTaskBloc extends Bloc<DailyTaskEvent, DailyTaskState> {
  final DailyTaskRepository _repository;

  DailyTaskBloc(this._repository) : super(DailyTaskInitial()) {
    on<DailyTaskEvent>((event, emit) {});
    on<GetDailyTaskEvent>(_mapGetDailyTaskEventToState);
    on<UpdateDailyTaskEvent>(_mapUpdateDailyTaskEventToState);
  }

  List<DailyTaskModel> dailyTasks = [];

  FutureOr<void> _mapGetDailyTaskEventToState(
      GetDailyTaskEvent event, Emitter<DailyTaskState> emit) async {
    emit(GetDailyTaskLoadingState());
    try {
      final response = await _repository.getDailyTasks();
      dailyTasks = response.data;
      emit(GetDailyTaskSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetDailyTaskFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapUpdateDailyTaskEventToState(
      UpdateDailyTaskEvent event, Emitter<DailyTaskState> emit) async {
    emit(UpdateDailyTaskLoadingState());
    try {
      final response = await _repository.updateTask(event.taskId);
      emit(UpdateDailyTaskSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(UpdateDailyTaskFailureState(e.toString()));
    }
  }
}
