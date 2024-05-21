import 'package:mentra/features/work_sheet/data/models/get_all_work_sheet_response.dart';
import 'package:mentra/features/work_sheet/data/models/get_questions_response.dart';
import 'package:mentra/features/work_sheet/data/models/get_work_sheet_details_response.dart';

abstract class WorkSheetRepository {
  Future<GetAllWorkSheetResponse> getWorkSheets();

  Future<GetQuestionsResponse> getQuestionaires(String workSheetId);

  Future<GetWorkSheetDetailsResponse> getWorkSheetDetails(String workSheetId);

  Future<dynamic> submitQuestionaires(Map<String, dynamic> questionnaire);

  Future<dynamic> markTask(String task);
}
