import 'package:mentra/features/notification/data/models/get_notifications_response.dart';
import 'package:mentra/features/notification/data/models/read_notification_response.dart';

abstract class NotificationsRepository {
  Future<GetNotificationsResponse> getNotifications();

  Future<ReadNotificationResponse> readNotification(String id);

  Future<dynamic> getNotificationDetails(String id);

  Future<dynamic> clearAllNotifications();
}
