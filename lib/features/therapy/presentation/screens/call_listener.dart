import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/presentation/screens/incoming_call_screen.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

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
    _listenForIncomingCalls();

    // listen for incoming video call
    // SignallingService.instance.socket!.on("newCall", (data) {
    //   if (mounted) {
    //     // set SDP Offer of incoming call
    //     // setState(() => incomingSDPOffer = data);
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  onEventReceived(event) {
    logger.w('Event from server:${event}');
    var data = (event as PusherEvent).data;

    if ((event).eventName == 'newCall') {
      // if (true) {

      try {
        IncomingCallResponse incomingCall = IncomingCallResponse.fromJson(jsonDecode(data));

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

        // CustomDialogs.showBottomSheet(
        //     rootNavigatorKey.currentState!.context,
        //     Container(
        //       height: 100,
        //       color: Pallets.white,
        //       child: Center(
        //         child: CustomNeumorphicButton(
        //             text: 'Accept',
        //             onTap: () {
        //               logger.w('CallerId :${incomingCall.callerId} CalleeId:2');
        //
        //               context.pushNamed(PageUrl.therapyCallScreen,
        //                   queryParameters: {
        //                     PathParam.calleeId: '2',
        //                     PathParam.callerId: incomingCall.callerId,
        //                     PathParam.offer:
        //                         jsonEncode(incomingCall.sdpOffer.toJson()),
        //                   });
        //
        //               // Navigator.push(
        //               //     rootNavigatorKey.currentState!.context,
        //               //     MaterialPageRoute(
        //               //       builder: (context) => CallScreen(
        //               //           callerId: incomingCall.callerId,
        //               //           calleeId: '2',
        //               //           offer: incomingCall.sdpOffer),
        //               //     ));
        //             },
        //             color: Pallets.primary),
        //       ),
        //     ));

        logger.w('New call');
      } catch (e, stack) {
        logger.e(e.toString(), stackTrace: stack);
        logger.w(stack);
      }
    }
  }

  onSubscriptionError(message, d) {}

  void _listenForIncomingCalls() async {
    var pusherService = await PusherChannelService.getInstance;
    var pusher = await pusherService.getClient;
    if (pusher != null) {
      logger.w('connecting');
      if (!pusher.channels.containsKey(injector.get<UserBloc>().userChannel)) {
        PusherChannel channel = await pusher.subscribe(
          channelName: injector.get<UserBloc>().userChannel,
          onSubscriptionError: (message, d) => onSubscriptionError(message, d),
          onSubscriptionSucceeded: (data) {
            // log('subscribed');
            // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
            // return data;a
          },
          onEvent: (event) => onEventReceived(event),
        );
        logger.w('connected');
      } else {
        logger.w('connected2');

        // pusher.getChannel('user_2')?.onEvent = onEventReceived;
      }

      await pusher.connect();
    }
  }

  void _disconnect() async {
    var pusherService = await PusherChannelService.getInstance;
    var pusher = await pusherService.getClient;
    pusher?.unsubscribe(channelName: injector.get<UserBloc>().userChannel);
    // pusher?.(channelName: 'user_2');

    logger.i('disconnected');
  }
}
