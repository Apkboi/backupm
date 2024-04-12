import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/tasks/data/models/get_daily_task_response.dart';
import 'package:mentra/features/tasks/data/models/update_daily_task_response.dart';
import 'package:mentra/features/tasks/domain/repository/daily_task_repository.dart';

class DailyTaskRepositoryImpl extends DailyTaskRepository {
  final NetworkService _networkService;

  DailyTaskRepositoryImpl(this._networkService);

  @override
  Future<GetDailyTakResponse> getDailyTasks() async {
    try {
      final response = await _networkService
          .call(UrlConfig.getDailyTasks, RequestMethod.get, data: {
        // "mood":mood
      });
      return GetDailyTakResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);

      rethrow;
    }
  }

  @override
  Future<UpdateDailyTaskResponse> updateTask(String taskId) async {
    try {
      final response = await _networkService.call(
          UrlConfig.updateDailyTasks, RequestMethod.post,
          data: {"daily_task_id": taskId});
      return UpdateDailyTaskResponse.fromJson(response.data);
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);

      rethrow;
    }
  }
}
