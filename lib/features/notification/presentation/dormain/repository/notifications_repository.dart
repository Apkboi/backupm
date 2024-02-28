abstract class NotificationsRepository{
  Future<dynamic> getNotifications();
  Future<dynamic> readNotification(String id);
  Future<dynamic> getNotificationDetails(String id);
}