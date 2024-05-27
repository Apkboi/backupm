import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';
import 'package:mentra/features/therapy/presentation/bloc/session/session_chat_bloc.dart';

class TherapyChatUserMessageItem extends StatefulWidget {
  const TherapyChatUserMessageItem({
    Key? key,
    required this.message,
    // this.child,
  }) : super(key: key);
  final TherapyChatMessage message;

  // final Widget? child;

  @override
  State<TherapyChatUserMessageItem> createState() =>
      _TherapyChatUserMessageItemState();
}

class _TherapyChatUserMessageItemState
    extends State<TherapyChatUserMessageItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 0.7.sw),
          child: ChatBubble(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7),
            backGroundColor: Pallets.secondary,
            clipper: ChatBubbleClipper3(
                type: BubbleType.sendBubble, nipSize: 4, radius: 15),
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: TextView(
                      text: widget.message.message,
                      fontSize: 15,
                      color: Pallets.black,
                      lineHeight: 1.5,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        5.verticalSpace,
        switch (widget.message.sendingState) {
          SendingState.loading => const TextView(text: 'Sending..'),
          SendingState.failed => Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  context
                      .read<SessionChatBloc>()
                      .add(ResendMessageEvent(widget.message));
                },
                style: TextButton.styleFrom(
                    side: const BorderSide(
                      width: 1,
                      color: Pallets.red,
                    ),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    foregroundColor: Pallets.red),
                child: const TextView(
                  text: 'Retry',
                  fontSize: 12,
                ),
              ),
            ),
          SendingState.success => Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(TimeUtil.formatTime(widget.message.time),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Pallets.black,
                    fontWeight: FontWeight.w600,
                  )),
            ),
        },
        6.verticalSpace
      ],
    );
  }
}
