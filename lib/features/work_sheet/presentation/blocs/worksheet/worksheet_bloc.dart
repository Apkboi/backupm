import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';
import 'package:mentra/features/work_sheet/data/repositories/work_sheet_repository.dart';

part 'worksheet_event.dart';
part 'worksheet_state.dart';


class WorkSheetBloc extends Bloc<WorkSheetEvent, WorkSheetState> {
  final WorkSheetRepository _workSheetRepository;

  WorkSheetBloc(this._workSheetRepository) : super(WorkSheetLoadingState()) {
    on<GetWorkSheetsEvent>(_mapGetWorkSheetsEventToState);
    on<GetQuestionairesEvent>(_mapGetQuestionairesEventToState);
    on<SubmitQuestionairesEvent>(_mapSubmitQuestionairesEventToState);
    on<MarkTaskEvent>(_mapMarkTaskEventToState);
  }

  Future<void> _mapGetWorkSheetsEventToState(
      GetWorkSheetsEvent event,
      Emitter<WorkSheetState> emit,
      ) async {
    emit(WorkSheetLoadingState());
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
    emit(WorkSheetLoadingState());
    try {
      final response = await _workSheetRepository.getQuestionaires();
      emit(GetQuestionairesSuccessState(response));
    } catch (e) {
      emit(WorkSheetFailureState(e.toString()));
    }
  }

  Future<void> _mapSubmitQuestionairesEventToState(
      SubmitQuestionairesEvent event,
      Emitter<WorkSheetState> emit,
      ) async {
    emit(WorkSheetLoadingState());
    try {
      final response = await _workSheetRepository.submitQuestionaires(event.payload);
      emit(SubmitQuestionairesSuccessState(response));
    } catch (e) {
      emit(WorkSheetFailureState(e.toString()));
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
}
