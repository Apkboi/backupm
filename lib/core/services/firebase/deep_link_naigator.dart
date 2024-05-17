import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/services/sentory/sentory_service.dart';
import 'package:mentra/features/dashboard/presentation/bloc/deep_link_bloc/deep_link_bloc.dart';
import 'package:mentra/features/therapy/data/models/incoming_call_notification_data.dart';

class DeepLinkNavigator {
  static void handleBackgroundMessages(RemoteMessage message) {
    if (message.notification?.title.toString() == 'Incoming Call') {
      try {
        SentryService.captureMessage('Received background call');
        logger.w('Incoming call');
        var incomingCallData =
            IncomingCallNotificationData.fromJson(message.data);

        CallKitService.instance.showIncomingCall(
            incomingCallData.webrtcDescriptionId.toString(),
            incomingCallData.therapist.name,
            callerImage: incomingCallData.therapist.avatar,
            extra: incomingCallData.toJson());
        SentryService.captureException(
            'This is a custom error for background calls');
      } catch (e, stack) {
        logger.e(e.toString());
        logger.e(stack.toString());
      }
    }

    return;
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

        return;
      } catch (e, stack) {
        logger.e(e.toString());
        logger.e(stack.toString());

        return;
      }
    }
  }

  static void handlePushNotificationClick(Map<String, dynamic> payload) {
    switch (payload['type']) {
      case 'session':
        if (isAuthenticated) {
          CustomRoutes.goRouter.goNamed(PageUrl.therapyScreen);
          injector.get<DeepLinkBloc>().add(DeepLinkCleared());
        }
        break;
    }
  }

  static get isAuthenticated =>
      CustomRoutes
              .goRouter.routerDelegate.currentConfiguration.last.route.path !=
          "/${PageUrl.passcodeAuthScreen}" &&
      SessionManager.instance.isLoggedIn;
}
