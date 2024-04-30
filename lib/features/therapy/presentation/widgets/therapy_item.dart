import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/screens/incoming_call_screen.dart';
import 'package:mentra/features/therapy/presentation/widgets/join_session_button.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_details_sheet.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../core/services/pusher/pusher_channel_service.dart';

class TherapyItem extends StatefulWidget {
  const TherapyItem({super.key, required this.session});

  final TherapySession session;

  @override
  State<TherapyItem> createState() => _TherapyItemState();
}

class _TherapyItemState extends State<TherapyItem> {
  final String selfCallerID =
      Random().nextInt(999999).toString().padLeft(6, '0');

  @override
  void initState() {
    // _listenForIncomingCalls();

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
    return HapticInkWell(
      onTap: () {
        CustomDialogs.showCupertinoBottomSheet(
            context,
            TherapyDetailsSheet(
              session: widget.session,
            ));
        // context.pushNamed(PageUrl.therapistChatScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const TherapyStatusIndicator(),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: widget.session.focus,
                      fontSize: 16,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
                    8.verticalSpace,
                    TextView(
                      text:
                          'Session with ${widget.session.therapist.user.name}.',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: TimeUtil.formartToDayTime(
                          widget.session.startsAt.toLocal()),
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    SessionButton(
                      startDate: widget.session.startsAt.toLocal(),
                      endDate: (widget.session.endsAt ??
                              widget.session.startsAt
                                  .add(const Duration(hours: 1)))
                          .toLocal(),
                      session: widget.session,
                    )
                  ],
                ),
              ),
              ImageWidget(
                imageUrl: widget.session.therapist.user.avatar,
                size: 45,
                borderRadius: BorderRadius.circular(30),
              )
            ],
          ),
        ),
      ),
    );
  }

  onEventReceived(event) {
    logger.w('Event from server:${event}');
    var data = (event as PusherEvent).data;

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
              calleeId: '2',
              offer: incomingCall.sdpOffer,
            );
          },
        );

        logger.w('New call');
      } catch (e, stack) {
        logger.e(e.toString(), stackTrace: stack);
      }
    }
  }

  onSubscriptionError(message, d) {}

  void _listenForIncomingCalls() async {
    var pusherService = await PusherChannelService.getInstance;
    var pusher = await pusherService.getClient;
    if (pusher != null) {
      logger.w('connecting');
      if (!pusher.channels.containsKey('user_2')) {
        PusherChannel channel = await pusher.subscribe(
          channelName: 'user_2',
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
    pusher?.unsubscribe(channelName: 'user_2');
    // pusher?.(channelName: 'user_2');

    logger.i('disconnected');
  }
}

class TherapyStatusIndicator extends StatelessWidget {
  const TherapyStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(37),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Active
              colors: [Color(0xffd4f7e9), Color(0xffeffaf6)],
              // History
              // colors: [Color(0xffe0e3e7), Color(0xffe0e3e7)],
              // Awaiting
              // colors: [Color(0xffffdac1), Color(0xfffef3eb)],
            )));
  }
}
