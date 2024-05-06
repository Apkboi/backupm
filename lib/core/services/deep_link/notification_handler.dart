import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:mentra/core/di/injector.dart';

class NotificationHandler {
  static final NotificationHandler _instance = NotificationHandler._internal();

  factory NotificationHandler() => _instance;

  NotificationHandler._internal();

  final MethodChannel _deepLinkChannel = const MethodChannel('com.your_app/deep_link');

  Future<void> handleForegroundNotification(RemoteMessage message) async {

  }

  Future<void> handleBackgroundNotification(RemoteMessage message) async {
    // Handle background notifications for potential app launch (optional)
    if (message.notification != null) {

      if(message.notification?.title.toString() =='newCall'){
        logger.w('New Call oo');
      }
      // Handle notification display logic (optional)
    }
  }
}
