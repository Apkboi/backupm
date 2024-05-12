import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/features/therapy/data/models/incoming_call_notification_data.dart';

class DeepLinkNavigator {
  static void handleBackgroundMessages(RemoteMessage message) {
    if (message.notification?.title.toString() == 'Incoming Call') {
      try {
        logger.w('Incoming call');
        var incomingCallData =
            IncomingCallNotificationData.fromJson(message.data);

        CallKitService.instance.showIncomingCall(
            incomingCallData.webrtcDescriptionId.toString(),
            incomingCallData.therapist.name,
            callerImage: incomingCallData.therapist.avatar,
            extra: incomingCallData.toJson());


      } catch (e, stack) {
        logger.e(e.toString());
        logger.e(stack.toString());
      }
    }
  }

  static void handleForegroundMessages(RemoteMessage message) {
    if (message.notification?.title.toString() == 'Incoming Call') {
      try {
        logger.w('Incoming call');
        var incomingCallData =
            IncomingCallNotificationData.fromJson(message.data);

        CallKitService.instance.showIncomingCall(
            incomingCallData.webrtcDescriptionId,
            incomingCallData.therapist.name,
            callerImage: incomingCallData.therapist.avatar,
            extra: incomingCallData.toJson());
      } catch (e, stack) {
        logger.e(e.toString());
        logger.e(stack.toString());
      }
    }
  }
}
