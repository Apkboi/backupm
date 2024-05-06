import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/screens/incoming_call_screen.dart';

class CallListener extends StatefulWidget {
  const CallListener({super.key, required this.child});

  final Widget child;

  @override
  State<CallListener> createState() => _CallListenerState();
}

class _CallListenerState extends State<CallListener> {
  final String selfCallerID =
      Random().nextInt(999999).toString().padLeft(6, '0');

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

  void _listenToPusherEvent(BuildContext context, PusherState state) {
    if (state is PusherEventReceivedState) {
      var event = state.event;

      logger.w('Event from server:${event}');
      var data = (event).data;

      if ((event).eventName == 'newCall') {
        // if (true) {

        try {
          IncomingCallResponse incomingCall =
              IncomingCallResponse.fromJson(jsonDecode(data));

          logger.i(event.data);
          // dynamic offer = data["sdpOffer"];
          // String callerId = data["callerId"];

          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return IncomingCallScreen(
                callerId: incomingCall.callerId,
                calleeId: injector.get<UserBloc>().appUser!.id,
                offer: incomingCall.sdpOffer,
              );
            },
          );

          logger.w('New call');
        } catch (e, stack) {
          logger.e(e.toString(), stackTrace: stack);
          logger.w(stack);
        }
      }
    }
  }

  void _listenToCallEvent(BuildContext context, CallState state) {
    if (state is AcceptCallState) {
      CustomDialogs.success('Event received');

// context.pushNamed(PageUrl.therapyCallScreen, queryParameters: {
      //   PathParam.calleeId: injector.get<UserBloc>().appUser?.id.toString(),
      //   PathParam.callerId: widget.callerId.toString(),
      //   PathParam.offer: jsonEncode(widget.offer?.toJson()),
      // });


    }
  }
}
