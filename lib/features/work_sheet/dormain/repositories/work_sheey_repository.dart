import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';
import 'package:mentra/features/work_sheet/data/models/get_questions_response.dart';
import 'package:mentra/features/work_sheet/data/repositories/work_sheet_repository.dart';

class WorkSheetRepositoryImpl extends WorkSheetRepository {
  final NetworkService _networkService;

  WorkSheetRepositoryImpl(this._networkService);

  @override
  Future<GetAllWorkSheetResponse> getWorkSheets() async {
    try {
      final response = await _networkService.call(
          UrlConfig.getWorkSheets, RequestMethod.get);

      return GetAllWorkSheetResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(
        e.toString(),
      );
      logger.e(
        stack.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<GetQuestionsResponse> getQuestionaires() async {
    final response = await _networkService.call(
        UrlConfig.getQuestionaires, RequestMethod.get);

    return response.data;
  }

  @override
  Future<GetQuestionsResponse> submitQuestionaires(
      Map<String, dynamic> questionnaire) async {
    final response = await _networkService.call(
        UrlConfig.submitQuestionaires, RequestMethod.post,
        data: questionnaire);

    return response.data;
  }

  @override
  Future<dynamic> markTask(String task) async {
    final response = await _networkService
        .call(UrlConfig.markTask, RequestMethod.post, data: task);

    return response.data;
  }
}
