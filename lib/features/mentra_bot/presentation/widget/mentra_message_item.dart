import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';
import '../../../../core/utils/time_util.dart';

class MentraMessageItem extends StatefulWidget {
  const MentraMessageItem({
    Key? key,
    required this.message,
    this.child,
    this.isTyping = false,
    required this.time,
  }) : super(key: key);
  final List<dynamic> message;
  final Widget? child;
  final bool isTyping;
  final DateTime time;

  @override
  State<MentraMessageItem> createState() => _MentraMessageItemState();
}

class _MentraMessageItemState extends State<MentraMessageItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    logger.i('forwading');

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 100), () {
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
        FadeTransition(
          opacity: _fadeAnimation,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: !widget.isTyping
                    ? EdgeInsets.only(top: 45.h,)
                    : EdgeInsets.only(top: 8.h),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 13,
                  child: ImageWidget(
                    imageUrl: Assets.images.pngs.launcherIcon.path,
                    fit: BoxFit.cover,

                    width: 35,
                    height: 60,
                    // size: 40,
                  )

                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.message.length,
                  (index) => Container(
                    constraints: BoxConstraints(maxWidth: 0.75.sw),
                    // margin: const EdgeInsets.only(bottom: ),
                    child: ChatBubble(
                      // margin: EdgeInsets.zero,
                      backGroundColor: Pallets.navy,
                      clipper: ChatBubbleClipper3(
                          type: BubbleType.receiverBubble,
                          nipSize: !widget.isTyping ? 5 : 3,
                          radius: !widget.isTyping ? 15 : 15),
                      child: Container(
                        padding:
                            widget.isTyping ? const EdgeInsets.all(4) : null,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(
                        //         !widget.isTyping ? 15 : 100),
                        //     color: Pallets.navy),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.isTyping)
                              SizedBox(
                                width: 35.w,
                                height: 5.h,
                                child: const SpinKitThreeBounce(
                                  color: Pallets.white,
                                  size: 14.0,
                                ),
                              ),
                            if (!widget.isTyping)
                              TextView(
                                  text: widget.isTyping
                                      ? 'Mentra is typing....'
                                      : widget.message.reversed.toList()[index],
                                  lineHeight: 1.5,
                                  color: Pallets.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            if (!widget.isTyping) 8.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!widget.isTyping)
          Container(
            constraints: BoxConstraints(
              maxWidth: 0.8.sw,
            ),
            padding: EdgeInsets.only(top: 5.h, left: 37.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(TimeUtil.formatTime(DateTime.now()),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Pallets.navy,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        6.verticalSpace,
      ],
    );
  }
}
