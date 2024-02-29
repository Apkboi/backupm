part of 'journal_bloc.dart';

abstract class JournalEvent extends Equatable {
  const JournalEvent();
}

class CreateJournalEvent extends JournalEvent {
  final String? promptId;
  final String body;

  CreateJournalEvent({this.promptId, required this.body});

  @override
  List<Object?> get props => [promptId, body];
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

  const DeleteJournalsEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
