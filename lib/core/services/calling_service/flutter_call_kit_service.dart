import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/core/services/firebase/firebase_error_logger.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:uuid/uuid.dart';

class CallKitService {
  static final CallKitService instance = CallKitService._internal();

  var _currentUuid;

  get currentUuid => _currentUuid;

  CallKitService._internal();

  // final BehaviorSubject<Call> _incomingCallSubject = BehaviorSubject<Call>();
  //
  // Stream<Call> get onIncomingCall => _incomingCallSubject.stream;

  Future<void> initialize() async {
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
      switch (event!.event) {
        case Event.actionCallIncoming:
          // TODO: received an incoming call
          break;
        case Event.actionCallStart:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          break;
        case Event.actionCallAccept:
          // TODO: accepted an incoming call
          // TODO: show screen calling in Flutter

          _onAcceptCall(event);

          break;
        case Event.actionCallDecline:
          // TODO: declined an incoming call

          // endCall();
          break;
        case Event.actionCallEnded:
          // TODO: ended an incoming/outgoing call
          break;
        case Event.actionCallTimeout:
          // TODO: missed an incoming call

          endAllCalls();
          break;
        case Event.actionCallCallback:
          // TODO: only Android - click action `Call back` from missed call notification
          break;
        case Event.actionCallToggleHold:
          // TODO: only iOS
          break;
        case Event.actionCallToggleMute:
          // TODO: only iOS
          break;
        case Event.actionCallToggleDmtf:
          // TODO: only iOS
          break;
        case Event.actionCallToggleGroup:
          // TODO: only iOS
          break;
        case Event.actionCallToggleAudioSession:
          // TODO: only iOS
          break;
        case Event.actionDidUpdateDevicePushTokenVoip:
          // TODO: only iOS
          break;
        case Event.actionCallCustom:
          // TODO: for custom action
          break;
      }
    });
  }

  Future<void> showIncomingCall(String callerId, String callerName,
      {Map<String, dynamic>? extra, required String callerImage}) async {
    // Configure CallKit with your desired settings
    _currentUuid = const Uuid().v4();
    CallKitParams callKitParams = CallKitParams(
      id: _currentUuid,
      nameCaller: callerName.toString(),
      appName: 'CallKit',
      normalHandle: 2,
      avatar: callerImage.toString(),
      // handle: '0123456789',
      type: 4,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: false,
        subtitle: 'Missed call',
        // callbackText: 'Call back',
      ),
      duration: 30000,
      extra: extra,
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: AndroidParams(
          isCustomNotification: false,
          isShowLogo: false,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: '#0955fa',
          backgroundUrl: callerImage,
          actionColor: '#4CAF50',
          textColor: '#ffffff',
          incomingCallNotificationChannelName: "Incoming Call",
          missedCallNotificationChannelName: "Missed Call",
          isShowCallID: false),
      ios: const IOSParams(
        iconName: 'LaunchImage',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    if (!await theirIsAnActiveCall()) {
      await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
    }

    logger.w('Call ringing');
  }

  void endCall() async {
    await FlutterCallkitIncoming.endCall(_currentUuid ?? '');
    _currentUuid = null;
  }

  void endAllCalls() async {
    _currentUuid = null;
    await FlutterCallkitIncoming.endAllCalls();
  }

  void _onAcceptCall(CallEvent event) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        // FlutterCallkitIncoming.startCall(
        //     CallKitParams.fromJson(jsonDecode(event.body.toString())));
        injector
            .get<CallCubit>()
            .acceptCall(event.body['extra']['webrtc_description_id']);
        endAllCalls();
      },
    );
    logger.w(event.body['extra']);
  }

  Map<String, dynamic> toCalKitMap(dynamic map) {
    Map<String, dynamic> newMap = {};
    for (var entry in map.entries) {
      if (entry.key is String && entry.value != null) {
        newMap[entry.key as String] = entry.value;
      }
    }
    return newMap;
  }

  bool isAppInForeground() {
    return WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
  }

  Future<void> checkAndNavigationCallingPage() async {
    FirestoreErrorLogService.logError(ErrorModel(
        message: "Cheking for active call",
        additionalData: {"data": "Checking"}));
    // TODO: ACCEPT CALLER ID
    try {
      Future.delayed(
        const Duration(seconds: 0),
        () async {
          var currentCall = await getCurrentCall();
          // logger.w(currentCall['extra']['webrtc_description_id']);

          FirestoreErrorLogService.logError(ErrorModel(
              message: currentCall.toString(),
              additionalData: {
                "data": "This is information about the currentcall"
              }));

          if (Platform.isIOS) {
            if (currentCall != null) {
              CustomRoutes.goRouter
                  .pushNamed(PageUrl.therapyCallScreen, queryParameters: {
                PathParam.calleeId:
                    injector.get<UserBloc>().appUser?.id.toString(),
                PathParam.callerId: currentCall['extra']
                    ['webrtc_description_id'],
              });
            }
          } else {
            if (currentCall != null &&
                (currentCall['accepted'] ||
                    currentCall['accepted'] == 'true')) {
              logger.w(currentCall['extra']['webrtc_description_id']);

              CustomRoutes.goRouter
                  .pushNamed(PageUrl.therapyCallScreen, queryParameters: {
                PathParam.calleeId:
                    injector.get<UserBloc>().appUser?.id.toString(),
                PathParam.callerId: currentCall['extra']
                    ['webrtc_description_id'],
              });
              //Navigate to your call screen.
            }
          }

          FirestoreErrorLogService.logError(ErrorModel(
              message: "Call Answered",
              additionalData: {"data": "Call Has been answered"}));
        },
      );
    } catch (e, stack) {
      FirestoreErrorLogService.logError(ErrorModel(
          message: e.toString(),
          stackTrace: stack,
          additionalData: {
            "data": "This is an error when call was accepted currentcall"
          }));
    }
  }

  Future<dynamic> getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        _currentUuid = calls[0]['id'];
        return calls[0];
      } else {
        _currentUuid = "";
        return null;
      }
    }
  }

  Future theirIsAnActiveCall() async {
    var currentCall = await getCurrentCall();
    return currentCall != null &&
        (currentCall['accepted'] || currentCall['accepted'] == 'true');
  }

  void answerCall() {
    // FlutterCallkitIncoming.startCall(params)
  }
}
