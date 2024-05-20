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
  const GetQuestionairesEvent();

  @override
  List<Object?> get props => [];
}

class SubmitQuestionairesEvent extends WorkSheetEvent {
  final dynamic payload;

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
