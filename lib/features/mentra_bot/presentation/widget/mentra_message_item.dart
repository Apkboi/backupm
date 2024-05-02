import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/options_color_scheme.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_typing_widget.dart';
import 'package:mentra/gen/assets.gen.dart';
import '../../../../core/utils/time_util.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

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
    return Builder(builder: (context) {
      if (widget.isTyping) {
        return const BotTypingWidget();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 12.h,
                ),
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
                              right: 8, bottom: 0, left: 15, top: 5),
                          backGroundColor: Pallets.navy,
                          clipper: ChatBubbleClipper3(
                              type: BubbleType.receiverBubble,
                              nipSize: 5,
                              radius: 15),
                          child: Container(
                            padding: widget.isTyping
                                ? const EdgeInsets.all(10)
                                : null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
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
                                8.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),
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
              context.read<MentraChatBloc>().allMessages.last.content ==
                  widget.mentraMessge.content)
            _OptionsWidget(message: widget.mentraMessge)
        ],
      );
    });
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
            HapticInkWell(
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
                      color: OptionsColorScheme.fromIndex(index).bgColor,
                    ),
                    child: Center(
                      child: TextView(
                        text: widget.message.options[index],
                        lineHeight: 1.5,
                        style: TextStyle(
                            color:
                                OptionsColorScheme.fromIndex(index).textColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
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
