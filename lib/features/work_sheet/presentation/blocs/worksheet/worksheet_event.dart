part of 'worksheet_bloc.dart';

// Base Event Class
abstract class WorkSheetEvent extends Equatable {
  const WorkSheetEvent();
}

// Specific Event Classes
class GetWorkSheetsEvent extends WorkSheetEvent {
  const GetWorkSheetsEvent();

  @override
  List<Object?> get props => [];
}

class GetQuestionairesEvent extends WorkSheetEvent {
  final String worksheetId;

  const GetQuestionairesEvent(this.worksheetId);

  @override
  List<Object?> get props => [];
}

class SubmitQuestionairesEvent extends WorkSheetEvent {
  final SubmitQuestionairePayload payload;

  const SubmitQuestionairesEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

class MarkTaskEvent extends WorkSheetEvent {
  final String taskId;

  const MarkTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class GetWorkSheetDetailsEvent extends WorkSheetEvent {
  final String workSheetId;

  const GetWorkSheetDetailsEvent(this.workSheetId);

  @override
  List<Object?> get props => [workSheetId];
}

class SortWorkSheetByDay extends WorkSheetEvent {
  final DayOfWeek day;

  const SortWorkSheetByDay(this.day);

  @override
  List<Object?> get props => [day];
}
