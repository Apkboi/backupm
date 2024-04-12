import 'package:flutter/material.dart';
import 'package:mentra/features/tasks/data/models/get_daily_task_response.dart';
import 'package:mentra/features/tasks/data/models/update_daily_task_response.dart';

abstract class DailyTaskRepository {
  Future<GetDailyTakResponse> getDailyTasks();
  Future<UpdateDailyTaskResponse> updateTask(String taskId);
}
