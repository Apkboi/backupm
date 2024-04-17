import 'package:mentra/common/models/success_response.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/journal/data/models/get_journals_response.dart';
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';
import 'package:mentra/features/journal/data/models/save_journal_response.dart';
import 'package:mentra/features/journal/dormain/repository/journals_repository.dart';

class JournalsRepositoryImpl extends JournalsRepository {
  final NetworkService _networkService;

  JournalsRepositoryImpl(this._networkService);

  @override
  Future<SaveJournalResponse> createJournal(
      {required String? promptId, required String body}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.saveJournals, RequestMethod.post,
          data: {"guided_prompt_id": promptId, "body": body});
      return SaveJournalResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SuccessResponse> deleteJournal({
    required String id,
  }) async {
    try {
      final response = await _networkService.call(
        UrlConfig.deleteJournal(id),
        RequestMethod.delete,
      );
      return SuccessResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetJournalsResponse> getJournals() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getJournals,
        RequestMethod.get,
      );
      return GetJournalsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GetPromptsResponse> getPrompts(dynamic categoryId) async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPrompts,
        RequestMethod.get,
      );
      return GetPromptsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SaveJournalResponse> updateJournal(
      {required String journalId,
      String? promptId,
      required String body}) async {
    try {
      final response = await _networkService.call(
          UrlConfig.updateJournal(journalId.toString()), RequestMethod.post,
          data: {"guided_prompt_id": promptId, "body": body});
      return SaveJournalResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getPromptsCategories() async {
    try {
      final response = await _networkService.call(
        UrlConfig.getPromptsCategory,
        RequestMethod.get,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
