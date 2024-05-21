part of 'worksheet_bloc.dart';

// Base State Class
abstract class WorkSheetState extends Equatable {
  const WorkSheetState();
}

class WorksheetInitial extends WorkSheetState {
  @override
  List<Object> get props => [];
}

// Specific State Classes
class WorkSheetLoadingState extends WorkSheetState {
  const WorkSheetLoadingState();

  @override
  List<Object?> get props => [];
}

// Specific State Classes
class GetQuestionaireLoadingState extends WorkSheetState {
  const GetQuestionaireLoadingState();

  @override
  List<Object?> get props => [];
}

class GetQuestionaireFailedState extends WorkSheetState {
  const GetQuestionaireFailedState(this.error);

  final String error;

  @override
  List<Object?> get props => [];
}

// Specific State Classes
class SubmitQuestionaireLoadingState extends WorkSheetState {
  const SubmitQuestionaireLoadingState();

  @override
  List<Object?> get props => [];
}

class GetWorkSheetsSuccessState extends WorkSheetState {
  final GetAllWorkSheetResponse response;

  const GetWorkSheetsSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class GetQuestionairesSuccessState extends WorkSheetState {
  final GetQuestionsResponse response;

  const GetQuestionairesSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class SubmitQuestionairesSuccessState extends WorkSheetState {
  final dynamic response;

  const SubmitQuestionairesSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class MarkTaskSuccessState extends WorkSheetState {
  final dynamic response;

  const MarkTaskSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class WorkSheetFailureState extends WorkSheetState {
  final String error;

  const WorkSheetFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class SubmitQuestionaireFailureState extends WorkSheetState {
  final String error;

  const SubmitQuestionaireFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class GetWorksheetDetailsLoadingState extends WorkSheetState {
  const GetWorksheetDetailsLoadingState();

  @override
  List<Object?> get props => [];
}

class GetWorksheetDetailsFailureState extends WorkSheetState {
  final String error;

  const GetWorksheetDetailsFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

class GetWorksheetDetailsSuccessState extends WorkSheetState {
  final List<WeeklyTask> response;

  const GetWorksheetDetailsSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}
