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
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';

class BCMentraMessageWidget extends StatefulWidget {
  const BCMentraMessageWidget({
    Key? key,
    required this.message,
    this.child,
    this.isTyping = false,
    this.showBot = false,
  }) : super(key: key);
  final List<dynamic> message;
  final bool isTyping;
  final bool showBot;

  final Widget? child;

  @override
  State<BCMentraMessageWidget> createState() => _BCMentraMessageWidgetState();
}

class _BCMentraMessageWidgetState extends State<BCMentraMessageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  bool get _canFowardAnimation =>
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

    Future.delayed(const Duration(milliseconds: 200), () {
      if (_canFowardAnimation) {
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
                        ? EdgeInsets.only(
                            top: 45.h,
                          )
                        : EdgeInsets.only(top: 9.h),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 13,
                      child: widget.showBot
                          ? ImageWidget(
                              imageUrl: Assets.images.pngs.launcherIcon.path,
                              fit: BoxFit.cover,

                              width: 35,
                              height: 60,
                              // size: 40,
                            )
                          : const SizedBox(
                              width: 60,
                            ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 0.75.sw,
                    ),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...List.generate(
                            widget.message.length,
                            (index) => Container(
                              // margin: const EdgeInsets.only(bottom: ),
                              padding: EdgeInsets.zero,
                              child: widget.showBot
                                  ? ChatBubble(
                                      margin: EdgeInsets.zero,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 5),
                                      backGroundColor: Pallets.navy,
                                      clipper: ChatBubbleClipper3(
                                          type: BubbleType.receiverBubble,
                                          nipSize: !widget.isTyping ? 5 : 3,
                                          radius: !widget.isTyping ? 15 : 15),
                                      child: Container(
                                        padding: widget.isTyping
                                            ? const EdgeInsets.all(7)
                                            : EdgeInsets.zero,
                                        child: _MessageContent(
                                            message: widget.message[index],
                                            isTyping: widget.isTyping,
                                            showBot: widget.showBot,
                                            child: widget.child),
                                      ),
                                    )
                                  : Container(
                                      padding: widget.isTyping
                                          ? const EdgeInsets.all(10)
                                          : const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              !widget.isTyping ? 15 : 100),
                                          color: Pallets.navy),
                                      child: _MessageContent(
                                          message: widget.message[index],
                                          isTyping: widget.isTyping,
                                          showBot: widget.showBot,
                                          child: widget.child),
                                    ),
                            ),
                          ),
                          3.verticalSpace,
                          if (!widget.isTyping)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
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
                        ],
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

class _MessageContent extends StatefulWidget {
  const _MessageContent({
    super.key,
    required this.message,
    this.child,
    this.isTyping = false,
    this.showBot = false,
  });

  final dynamic message;
  final bool isTyping;
  final bool showBot;

  final Widget? child;

  @override
  State<_MessageContent> createState() => _MessageContentState();
}

class _MessageContentState extends State<_MessageContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            text: widget.isTyping ? 'Mentra is typing....' : widget.message,
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
      ],
    );
  }
}
