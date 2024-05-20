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

class GetWorkSheetsSuccessState extends WorkSheetState {
  final GetAllWorkSheetResponse response;

  const GetWorkSheetsSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class GetQuestionairesSuccessState extends WorkSheetState {
  final dynamic response;

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


