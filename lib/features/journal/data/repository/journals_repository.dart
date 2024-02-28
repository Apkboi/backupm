abstract class JournalsRepository {
  Future<dynamic> createJournal(dynamic payload);
  Future<dynamic> getPrompts();
  Future<dynamic> getJournals();
  Future<dynamic> deleteJournals(String id);
}