import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/firebase/deep_link_naigator.dart';
import 'package:mentra/core/theme/pallets.dart';

// import 'package:plain_notification_token/plain_notification_token.dart';

final NotificationService notificationService = NotificationService();

String notiToken = '';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Define a top-level named handler which background/terminated messages will
/// call.

/// To verify things are working, check out the native platform logs.
///
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('Handling a background message ${message.data}');
  logger.i('Handling a background message ${message.notification?.title}');
  var body = message.notification?.body ?? message.data['body'];
  // await notificationService.initializeNotification();
  // await Firebase.initializeApp();
  DeepLinkNavigator.handleBackgroundMessages(message);
  if (message.notification?.title.toString() != 'Incoming Call') {
    notificationService.triggerHeadsUp(
      message.notification.hashCode,
      message.notification?.title ?? message.data['title'],
      message.notification?.body ?? message.data['body'],
    );
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

class NotificationService {
  NotificationService();

  /// get users device token
  String? token;

  /// Initialize notification
  Future<void> initializeNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@drawable/launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableLights: true,
        showBadge: true,
        playSound: true,
      );

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // await FirebaseMessaging.instance
    //     .subscribeToTopic("all"); //subscribe firebase message on topic

    // await FirebaseMessaging.instance.subscribeToTopic('kusnap');
    _triggerAllSetUp();
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    ///
  }

  /// Triggers all notification
  void _triggerAllSetUp() async {
    _requestPermission();
    getInitialMessage();
    _listenToMessage();
    _openMessageApp();
    _getToken();
    _refreshToken();
  }

  _requestPermission() {
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    /// initialize
    ///
  }

  /// Get initialize messages
  Future<RemoteMessage?> getInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      logger.i(message);

      return message;
    }

    return null;
  }

  /// Get initialize messages
  void _listenToMessage() async {
    // await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('Got a message whilst in the foreground!');
      logger.i('Message data: ${message.data}');

      DeepLinkNavigator.handleForegroundMessages(message);
      if (message.notification?.title.toString() != 'Incoming Call') {
        notificationService.triggerHeadsUp(
          message.notification.hashCode,
          message.notification?.title ?? message.data['title'],
          message.notification?.body ?? message.data['body'],
        );
      }

      //
    });
  }

  void _openMessageApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i(
          'A new onMessageOpenedApp event was published! ${message.data['test']}');
    });
  }

  /// Get users token
  void _getToken() async {
    try {
      // final plainNotificationToken = PlainNotificationToken();

      token = await FirebaseMessaging.instance.getToken();

      notiToken = token ?? '';
      // logger.e(notiToken);
      logger.i('My Token: $token');
    } catch (e) {
      logger.e(e);
    }
  }

  /// Refresh users token
  void _refreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      logger.d('Refresh: $event');
    });
  }

  void triggerHeadsUp(int hashCode, data, data2) {
    flutterLocalNotificationsPlugin.show(
      hashCode,
      data,
      data2,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: "launcher",
          importance: Importance.defaultImportance,
          priority: Priority.high,
          enableLights: true,
          color: Pallets.primary,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}
// duTCCKu0Y0j_mH6x2C-VP_:APA91bHuWI3pwOcr5oY35xMV7_84DICprR3_kC9-WvcvAzV31pjAow5Nx7xxeSqsJc5AcigQK5aHywbquONqG4sAof72w_Q5uemO1LmUHaV3cBiYrNT1Z6CYSbsQzdazbn3m9K3FBwGm
// 5480c256e09588dbd02918899311dad7561ecd16811e0a1bae983744bfbca7cb
