import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/common/models/day_of_week.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/utils/extensions/date_extensions.dart';
import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';
import 'package:mentra/features/work_sheet/data/models/get_questions_response.dart';
import 'package:mentra/features/work_sheet/data/models/submit_questionaire_payload.dart';
import 'package:mentra/features/work_sheet/data/repositories/work_sheet_repository.dart';
part 'worksheet_event.dart';
part 'worksheet_state.dart';

class WorkSheetBloc extends Bloc<WorkSheetEvent, WorkSheetState> {
  final WorkSheetRepository _workSheetRepository;

  List<WeeklyTask> stagedTasks = [];
  List<WeeklyTask> weeklyTasks = [];

  WorkSheetBloc(this._workSheetRepository) : super(WorkSheetLoadingState()) {
    on<GetWorkSheetsEvent>(_mapGetWorkSheetsEventToState);
    on<GetQuestionairesEvent>(_mapGetQuestionairesEventToState);
    on<SubmitQuestionairesEvent>(_mapSubmitQuestionairesEventToState);
    on<MarkTaskEvent>(_mapMarkTaskEventToState);
    on<GetWorkSheetDetailsEvent>(_mapMGetWorkSheetDetailsEventToState);
    on<SortWorkSheetByDay>(_mapSortWorkSheetByDayToState);
  }

  var selectedDay = DateTime.now().dayOfWeek;

  Future<void> _mapGetWorkSheetsEventToState(
    GetWorkSheetsEvent event,
    Emitter<WorkSheetState> emit,
  ) async {
    emit(const WorkSheetLoadingState());
    try {
      final response = await _workSheetRepository.getWorkSheets();
      emit(GetWorkSheetsSuccessState(response));
    } catch (e) {
      emit(WorkSheetFailureState(e.toString()));
    }
  }

  Future<void> _mapGetQuestionairesEventToState(
    GetQuestionairesEvent event,
    Emitter<WorkSheetState> emit,
  ) async {
    emit(const GetQuestionaireLoadingState());
    try {
      final response =
          await _workSheetRepository.getQuestionaires(event.worksheetId);
      emit(GetQuestionairesSuccessState(response));
    } catch (e) {
      emit(GetQuestionaireFailedState(e.toString()));
    }
  }

  Future<void> _mapSubmitQuestionairesEventToState(
    SubmitQuestionairesEvent event,
    Emitter<WorkSheetState> emit,
  ) async {
    emit(const SubmitQuestionaireLoadingState());
    try {
      final response = await _workSheetRepository
          .submitQuestionaires(event.payload.toJson());
      emit(SubmitQuestionairesSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(SubmitQuestionaireFailureState(e.toString()));
    }
  }

  Future<void> _mapMarkTaskEventToState(
    MarkTaskEvent event,
    Emitter<WorkSheetState> emit,
  ) async {
    emit(const WorkSheetLoadingState());
    try {
      final response = await _workSheetRepository.markTask(event.taskId);
      emit(MarkTaskSuccessState(response));
    } catch (e) {
      emit(WorkSheetFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapMGetWorkSheetDetailsEventToState(
      GetWorkSheetDetailsEvent event, Emitter<WorkSheetState> emit) async {
    emit(const GetWorksheetDetailsLoadingState());
    try {
      final response =
          await _workSheetRepository.getWorkSheetDetails(event.workSheetId);
      weeklyTasks = response.data.weeklyTasks;

      sortWorkSheetByDay(emit: emit);

      // emit(GetWorksheetDetailsSuccessState(weeklyTasks));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetWorksheetDetailsFailureState(e.toString()));
    }
  }

  sortWorkSheetByDay({
    DayOfWeek? dayOfWeek,
    required Emitter<WorkSheetState> emit,
  }) {
    if (dayOfWeek != null) {
      selectedDay = dayOfWeek;
    }
    stagedTasks = weeklyTasks
        .where((element) =>
            element.day.toLowerCase() == selectedDay.fullDay.toLowerCase())
        .toList();

    emit(GetWorksheetDetailsSuccessState(stagedTasks));
  }

  FutureOr<void> _mapSortWorkSheetByDayToState(
      SortWorkSheetByDay event, Emitter<WorkSheetState> emit) {
    sortWorkSheetByDay(emit: emit, dayOfWeek: event.day);
    // logger.w(stagedTasks.length);
  }
}
