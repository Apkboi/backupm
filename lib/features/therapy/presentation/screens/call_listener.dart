import 'dart:convert';
import 'dart:developer' as d;
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/firebase/firebase_error_logger.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/screens/incoming_call_screen.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class CallListener extends StatefulWidget {
  const CallListener({super.key, required this.child});

  final Widget child;

  @override
  State<CallListener> createState() => _CallListenerState();
}

class _CallListenerState extends State<CallListener>
    with WidgetsBindingObserver {
  final String selfCallerID =
      Random().nextInt(999999).toString().padLeft(6, '0');

  var debouncer = Debouncer(milliseconds: 500);

  bool isBackground = false;
  dynamic pendingCall;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallCubit, CallState>(
      listener: _listenToCallEvent,
      bloc: injector.get(),
      child: BlocListener<PusherCubit, PusherState>(
        listener: _listenToPusherEvent,
        bloc: injector.get(),
        child: widget.child,
      ),
    );
  }

  // void _listenForIncomingCalls() async {
  //
  // }

  void _disconnect() async {
    var pusherService = await PusherChannelService.getInstance;
    var pusher = await pusherService.getClient;
    pusher?.unsubscribe(channelName: injector.get<UserBloc>().userChannel);
    // pusher?.(channelName: 'user_2');
  }

  Future<void> _listenToPusherEvent(
      BuildContext context, PusherState state) async {
    if (state is PusherEventReceivedState) {
      var event = state.event;
      logger.w('Event from server:${event}');
      d.log('Event from server:${event.data}');
      var data = (event).data;
      if ((event).eventName == 'newCall') {
        if (Platform.isIOS && isBackground) {
          pendingCall = data;
        }
        showIncomingScreen(
          data,
        );
      }
    }
  }

  void showIncomingScreen(
    data,
  ) {
    try {
      IncomingCallResponse incomingCall =
          IncomingCallResponse.fromJson(jsonDecode(data));
      // logger.i(event.data);
      var currentRoute = CustomRoutes
          .goRouter.routerDelegate.currentConfiguration.last.route.path;

      // if (!await CallKitService.instance.theirIsAnActiveCall()) {
      debouncer.run(() {
        if (currentRoute != '/${PageUrl.therapyCallScreen}') {
          showGeneralDialog(
            context: rootNavigatorKey.currentState!.context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return IncomingCallScreen(
                callerId: incomingCall.callerId ?? 0,
                calleeId: injector.get<UserBloc>().appUser!.id,
                offer: incomingCall.sdpOffer,
                caller: incomingCall.therapist,
                sessionId: incomingCall.therapySessionId,
              );
            },
          );
        }
      });
      // }
    } catch (e, stack) {
      logger.e(e.toString(), stackTrace: stack);
      logger.e(stack);
    }
  }

  void _listenToCallEvent(BuildContext context, CallState state) {
    if (state is AcceptCallState) {
      var currentRoute = CustomRoutes
          .goRouter.routerDelegate.currentConfiguration.last.route.path;

      if (currentRoute == '/${PageUrl.therapyCallScreen}') {
        Navigator.pop(rootNavigatorKey.currentState!.context);
        CustomRoutes.goRouter
            .pushNamed(PageUrl.therapyCallScreen, queryParameters: {
          PathParam.calleeId: injector.get<UserBloc>().appUser?.id.toString(),
          PathParam.callerId: state.callerId.toString(),
          // PathParam.offer: jsonEncode(widget.offer?.toJson()),
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    FirestoreErrorLogService.logError(
        ErrorModel(message: state.name, additionalData: {
      "pendingCall": pendingCall,
    }));

    if (state == AppLifecycleState.resumed && pendingCall != null) {
      FirestoreErrorLogService.logError(
          ErrorModel(message: state.name, additionalData: {
        "pendingCall": pendingCall,
        "action": "showing dialog on resumed state",
      }));
      showIncomingScreen(pendingCall);
    }
  }
}
