import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/features/notification/presentation/dormain/repository/notifications_repository.dart';

class NotificationRepositoryImpl extends NotificationsRepository {
  final NetworkService _networkService;

  NotificationRepositoryImpl(this._networkService);

  @override
  Future<dynamic> getNotifications() async {
    final response = await _networkService.call(
        UrlConfig.getNotificationsEndpoint, RequestMethod.get);

    return response.data;
  }

  @override
  Future<dynamic> readNotification(String id) async {
    final response = await _networkService.call(
        UrlConfig.readNotificationEndpoint, RequestMethod.post,
        data: {"id": id});

    return response.data;
  }

  @override
  Future<dynamic> getNotificationDetails(String id) async {
    final response = await _networkService.call(
        UrlConfig.getNotificationDetailsEndpoint, RequestMethod.get,
        data: {"id": id});

    return response.data;
  }
}
