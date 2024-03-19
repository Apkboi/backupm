import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';

class BCMentraMessageWidget extends StatefulWidget {
  const BCMentraMessageWidget({
    Key? key,
    required this.message,
    this.child,
    this.isTyping = false,
  }) : super(key: key);
  final List<dynamic> message;
  final bool isTyping;

  final Widget? child;

  @override
  State<BCMentraMessageWidget> createState() => _BCMentraMessageWidgetState();
}

class _BCMentraMessageWidgetState extends State<BCMentraMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool get _canForward =>
      widget.isTyping ||
      context
              .read<BotChatCubit>()
              .stagedMessages
              .reversed
              .toList()
              .last
              .message ==
          widget.message[0];

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

    Future.delayed(const Duration(milliseconds: 200), () {
      if (_canForward) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.isTyping) {
    //   _controller.forward();
    // }
    return BlocConsumer<BotChatCubit, BotChatState>(
      bloc: context.read(),
      listener: (context, state) {
        logger.i(widget.message[0]);
        if (state is RemoveTypingState && widget.message[0] == '') {
          _controller.reverse();
        }
        if (state is QuestionUpdatedState) {
          _controller.forward();
        }
        // logger.i('cubit message'+context.read<BotChatCubit>().currentQuestion!.message.toString());
        // logger.i('this message' + widget.message.reversed.toList()[0]);
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity:
                  context.read<BotChatCubit>().stagedMessages.last.message ==
                          widget.message[0]
                      ? _fadeAnimation
                      : Animation.fromValueListenable(ValueNotifier(1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: !widget.isTyping
                        ? EdgeInsets.only(top: 45.h, right: 6.w)
                        : EdgeInsets.only(right: 6.w, top: 8.h),
                    child: CircleAvatar(
                      backgroundColor: Pallets.lighterBlue,
                      radius: 14,
                      child: ImageWidget(
                        imageUrl: Assets.images.pngs.mentraBig.path,
                        fit: BoxFit.cover,
                        size: 25,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.message.length,
                      (index) => Container(
                        constraints: BoxConstraints(
                          maxWidth: 0.75.sw,
                        ),
                        // margin: const EdgeInsets.only(bottom: ),
                        padding: EdgeInsets.zero,
                        child: ChatBubble(
                          margin: EdgeInsets.zero,
                          backGroundColor: Pallets.navy,
                          clipper: ChatBubbleClipper3(
                              type: BubbleType.receiverBubble,
                              nipSize: !widget.isTyping ? 5 : 3,
                              radius: !widget.isTyping ? 15 : 15),
                          child: Container(
                            padding: widget.isTyping
                                ? const EdgeInsets.all(4)
                                : null,

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
                                if (widget.child != null)
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: widget.child!,
                                  ),
                                if (!widget.isTyping && widget.child == null)
                                  TextView(
                                    text: widget.isTyping
                                        ? 'Mentra is typing....'
                                        : widget.message.toList()[index],
                                    // lineHeight: 1.5,

                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                      color: Pallets.white,
                                      fontSize: 15.sp,
                                      height: 1.5,
                                      wordSpacing: 1.5,

                                      // letterSpacing: 2
                                    ),
                                  ),
                                if (!widget.isTyping) 8.verticalSpace,
                                if (!widget.isTyping)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                        TimeUtil.formatTime(DateTime.now()),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Pallets.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  )
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
            6.verticalSpace,
          ],
        );
      },
    );
  }
}
