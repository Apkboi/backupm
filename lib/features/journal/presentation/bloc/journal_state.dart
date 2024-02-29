part of 'journal_bloc.dart';

// State classes
abstract class JournalState extends Equatable {
  const JournalState();
}

class JournalInitial extends JournalState {
  @override
  List<Object?> get props => [];
}

class CreateJournalLoadingState extends JournalState {
  @override
  List<Object?> get props => [];
}

class CreateJournalSuccessState extends JournalState {
  final dynamic response;

  CreateJournalSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class CreateJournalFailureState extends JournalState {
  final String error;

  CreateJournalFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetPromptsLoadingState extends JournalState {
  @override
  List<Object?> get props => [];
}

class GetPromptsSuccessState extends JournalState {
  final GetPromptsResponse response;

  const GetPromptsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetPromptsFailureState extends JournalState {
  final String error;

  const GetPromptsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class GetJournalsLoadingState extends JournalState {
  @override
  List<Object?> get props => [];
}

class GetJournalsSuccessState extends JournalState {
  final GetJournalsResponse response;

  GetJournalsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class GetJournalsFailureState extends JournalState {
  final String error;

  GetJournalsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

// State classes
class DeleteJournalsLoadingState extends JournalState {
  @override
  List<Object?> get props => [];
}

class DeleteJournalsSuccessState extends JournalState {
  final dynamic response;

  DeleteJournalsSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class DeleteJournalsFailureState extends JournalState {
  final String error;

  DeleteJournalsFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
