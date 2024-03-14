import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

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
      curve: Curves.easeInOut,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      // if (widget.isTyping) {
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
    // if (widget.isTyping) {
    //   _controller.forward();
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 36.h, right: 10),
                  child: CircleAvatar(
                    backgroundColor: Pallets.lighterBlue,
                    child: ImageWidget(
                      imageUrl: Assets.images.pngs.mentraBig.path,
                      fit: BoxFit.cover,
                      size: 40,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.message.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2 + 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              !widget.isTyping ? 15 : 100),
                          color: Pallets.navy),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                              text: widget.isTyping
                                  ? 'Mentra is typing....'
                                  : widget.message.reversed.toList()[index],
                              lineHeight: 1.5,
                              color: Pallets.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                          if (!widget.isTyping) 8.verticalSpace,
                          if (!widget.isTyping)
                            Text(TimeUtil.formatTime(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Pallets.white,
                                  fontWeight: FontWeight.w600,
                                ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
