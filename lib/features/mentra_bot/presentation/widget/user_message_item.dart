import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';

class UserMessageItem extends StatefulWidget {
  const UserMessageItem({
    Key? key,
    required this.message,
    this.child,
    required this.time,
  }) : super(key: key);
  final MentraChatModel message;
  final Widget? child;
  final DateTime time;

  @override
  State<UserMessageItem> createState() => _UserMessageItemState();
}

class _UserMessageItemState extends State<UserMessageItem> {
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
                type: BubbleType.sendBubble, nipSize: 4, radius: 15.r),
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: widget.child ??
                      TextView(
                          text: widget.message.content,
                          color: Pallets.black,
                          lineHeight: 1.5,
                          fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        5.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(TimeUtil.formatTime(widget.time),
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 11.sp,
                color: Pallets.black,
                fontWeight: FontWeight.w600,
              )),
        ),
        if (widget.message.sendingState == SendingState.failed)
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                context
                    .read<MentraChatBloc>()
                    .add(RetryMessageEvent(widget.message));
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
        6.verticalSpace
      ],
    );
  }
}
