import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';

class UserMessageItem extends StatefulWidget {
  const UserMessageItem({
    Key? key,
    required this.message,
    this.child, required this.time,
  }) : super(key: key);
  final dynamic message;
  final Widget? child;
  final DateTime time;

  @override
  State<UserMessageItem> createState() => _UserMessageItemState();
}

class _UserMessageItemState extends State<UserMessageItem>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    logger.i('forwading');

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 0.7.sw),
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Pallets.secondary),

          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ChatBubble(
              backGroundColor: Pallets.secondary,
              clipper: ChatBubbleClipper3(
                  type: BubbleType.sendBubble, nipSize: 4, radius: 15),
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  widget.child ??
                      TextView(
                          text: widget.message[0],
                          fontSize: 15.sp,
                          color: Pallets.black,
                          lineHeight: 1.5,
                          fontWeight: FontWeight.w500),
                  Text(TimeUtil.formatTime(widget.time),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Pallets.black,
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
          ),
        ),
        6.verticalSpace
      ],
    );
  }
}
