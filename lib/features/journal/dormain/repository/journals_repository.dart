import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/features/journal/data/models/get_journals_response.dart';
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';
import 'package:mentra/features/journal/data/models/save_journal_response.dart';

abstract class JournalsRepository {
  Future<SaveJournalResponse> createJournal(
      {required String? promptId, required String body});

  Future<GetPromptsResponse> getPrompts();

  Future<GetJournalsResponse> getJournals();

  Future<SuccessResponse> deleteJournal(
      {required String id, });
}
