import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';

class BCUserMessageWidget extends StatefulWidget {
  const BCUserMessageWidget({
    Key? key,
    required this.message,
    this.child,
  }) : super(key: key);
  final dynamic message;
  final Widget? child;

  @override
  State<BCUserMessageWidget> createState() => _BCUserMessageWidgetState();
}

class _BCUserMessageWidgetState extends State<BCUserMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 0.7.sw),
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Pallets.secondary),

          child: ChatBubble(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            backGroundColor: Pallets.secondary,
            clipper: ChatBubbleClipper3(
                type: BubbleType.sendBubble, nipSize: 4, radius: 15),
            alignment: Alignment.centerRight,
            child: Container(
              // padding: widget.isTyping
              //     ? const EdgeInsets.all(4)
              //     : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.child ??
                      TextView(
                          text: widget.message[0],
                          // fontSize: 15.sp,
                          color: Pallets.black,
                          lineHeight: 1.5,
                          fontWeight: FontWeight.w500),
                ],
              ),
            ),
          ),
        ),
        5.verticalSpace,
        Text(TimeUtil.formatTime(DateTime.now()),
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 11.sp,
              color: Pallets.black,
              fontWeight: FontWeight.w600,
            )),
        6.verticalSpace
      ],
    );
  }


}
