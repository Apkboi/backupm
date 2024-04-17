import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/features/journal/data/models/get_journals_response.dart';
import 'package:mentra/features/journal/data/models/get_prompts_category_endpoint.dart';
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';
import 'package:mentra/features/journal/dormain/repository/journals_repository.dart';

part 'journal_event.dart';

part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalsRepository _journalRepository;

  JournalBloc(this._journalRepository) : super(JournalInitial()) {
    on<CreateJournalEvent>(_mapCreateJournalEventToState);
    on<GetPromptsEvent>(_mapGetPromptsEventToState);
    on<GetJournalsEvent>(_mapGetJournalsEventToState);
    on<DeleteJournalsEvent>(_mapDeleteJournalsEventToState);
    on<UpdateJournalEvent>(_mapUpdateJournalEventToState);
    // on<UpdateJournalEvent>(_mapUpdateJournalEventToState);
    on<GetPromptsCategoriesEvent>(_mapGetPromptsCategoriesEventToState);
  }

  List<GuidedJournal>? journals;

  // final

  Future<void> _mapUpdateJournalEventToState(
    UpdateJournalEvent event,
    Emitter<JournalState> emit,
  ) async {
    emit(UpdateJournalLoadingState());
    try {
      final response = await _journalRepository.updateJournal(
        journalId: event.journalId,
        promptId: event.promptId,
        body: event.body,
      );
      emit(UpdateJournalSuccessState(response: response));
    } catch (e) {
      emit(UpdateJournalFailureState(error: e.toString()));
    }
  }

  Future<void> _mapCreateJournalEventToState(
    CreateJournalEvent event,
    Emitter<JournalState> emit,
  ) async {
    emit(CreateJournalLoadingState());
    try {
      final response = await _journalRepository.createJournal(
          promptId: event.promptId, body: event.body);
      emit(CreateJournalSuccessState(response: response));
    } catch (e) {
      emit(CreateJournalFailureState(error: e.toString()));
    }
  }

  Future<void> _mapGetPromptsEventToState(
    GetPromptsEvent event,
    Emitter<JournalState> emit,
  ) async {
    emit(GetPromptsLoadingState());
    try {
      final response = await _journalRepository.getPrompts(event.categoryId);
      emit(GetPromptsSuccessState(response: response));
    } catch (e) {
      emit(GetPromptsFailureState(error: e.toString()));
    }
  }

  Future<void> _mapGetJournalsEventToState(
    GetJournalsEvent event,
    Emitter<JournalState> emit,
  ) async {
    emit(GetJournalsLoadingState());
    try {
      final response = await _journalRepository.getJournals();
      journals = response.data;
      emit(GetJournalsSuccessState(response: response));
    } catch (e) {
      emit(GetJournalsFailureState(error: e.toString()));
    }
  }

  Future<void> _mapDeleteJournalsEventToState(
    DeleteJournalsEvent event,
    Emitter<JournalState> emit,
  ) async {
    emit(DeleteJournalsLoadingState());
    try {
      final response = await _journalRepository.deleteJournal(id: event.id);
      emit(DeleteJournalsSuccessState(response: response));
    } catch (e) {
      emit(DeleteJournalsFailureState(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetPromptsCategoriesEventToState(
      GetPromptsCategoriesEvent event, Emitter<JournalState> emit) async {
    emit(GetPromptsCategoryLoadingState());
    try {
      final response = await _journalRepository.getPromptsCategories();
      emit(GetPromptsCategorySuccessState(response: response));
    } catch (e) {
      emit(GetPromptsCategoryFailureState(error: e.toString()));
    }
  }
}
