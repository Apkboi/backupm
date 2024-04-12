import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';
import '../../../../core/utils/time_util.dart';

class MentraMessageItem extends StatefulWidget {
  const MentraMessageItem({
    Key? key,
    required this.message,
    this.child,
    this.isTyping = false,
    required this.time,
    required this.mentraMessge,
  }) : super(key: key);
  final List<dynamic> message;
  final Widget? child;
  final bool isTyping;
  final DateTime time;
  final MentraChatModel mentraMessge;

  @override
  State<MentraMessageItem> createState() => _MentraMessageItemState();
}

class _MentraMessageItemState extends State<MentraMessageItem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: !widget.isTyping
                  ? EdgeInsets.only(
                      bottom: 12.h,
                    )
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
                  )),
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
                      (index) => ChatBubble(
                        // margin: EdgeInsets.zero,
                        padding: const EdgeInsets.only(
                            right: 15, bottom: 0, left: 15, top: 5),
                        backGroundColor: Pallets.navy,
                        clipper: ChatBubbleClipper3(
                            type: BubbleType.receiverBubble,
                            nipSize: !widget.isTyping ? 5 : 3,
                            radius: !widget.isTyping ? 15 : 15),
                        child: Container(
                          padding:
                              widget.isTyping ? const EdgeInsets.all(10) : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                    text: widget.message.reversed
                                        .toList()[index]
                                        .toString()
                                        .trim(),
                                    lineHeight: 1.5,
                                    color: Pallets.white,
                                    fontSize: 15.sp,
                                    wordSpacing: 1,
                                    fontWeight: FontWeight.w500),
                              if (!widget.isTyping) 8.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!widget.isTyping)
                      Text(TimeUtil.formatTime(widget.time.toLocal()),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Pallets.navy,
                            fontWeight: FontWeight.w600,
                          )),
                    6.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
        if (widget.mentraMessge.options.isNotEmpty &&
            context.read<MentraChatBloc>().allMessage.last.content ==
                widget.mentraMessge.content)
          _OptionsWidget(message: widget.mentraMessge)
      ],
    );
  }
}

class _OptionsWidget extends StatefulWidget {
  const _OptionsWidget({super.key, required this.message});

  final MentraChatModel message;

  @override
  State<_OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<_OptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.message.options.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 16),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                context.read<MentraChatBloc>().add(ContinueSessionEvent(
                    context.read<MentraChatBloc>().sessionId,
                    widget.message.options[index]));
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    // width: 100,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      // shape: BoxShape.circle,
                      color: Pallets.secondary,
                    ),
                    child: Center(
                      child: TextView(
                        text: widget.message.options[index],
                        lineHeight: 1.5,
                        style: TextStyle(
                            color: Pallets.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
