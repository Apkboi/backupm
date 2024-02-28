part of 'journal_bloc.dart';

abstract class JournalEvent extends Equatable {
  const JournalEvent();
}

class CreateJournalEvent extends JournalEvent {
  final dynamic payload;

  CreateJournalEvent({required this.payload});

  @override
  List<Object?> get props => [payload];
}

class GetPromptsEvent extends JournalEvent {
  @override
  List<Object?> get props => [];
}

class GetJournalsEvent extends JournalEvent {
  @override
  List<Object?> get props => [];
}
// Event class
class DeleteJournalsEvent extends JournalEvent {
  final String id;

  DeleteJournalsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
