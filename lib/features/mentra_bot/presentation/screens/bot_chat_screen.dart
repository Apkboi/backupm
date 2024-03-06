import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_message_box.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/talk_to_mentra_input_fields.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BotChatScreen extends StatefulWidget {
  const BotChatScreen({super.key});

  @override
  State<BotChatScreen> createState() => _BotChatScreenState();
}

class _BotChatScreenState extends State<BotChatScreen> {
  final botChatCubit = BotChatCubit();

  @override
  void initState() {
    // TODO:ACCEPT BOTFLOW FROM CONSTRUCTOR
    botChatCubit.startMessage(BotChatFlow.welcome);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => botChatCubit,
      lazy: false,
      child: BlocConsumer<BotChatCubit, BotChatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CustomAppBar(
              tittleText: 'Talk to Mentra',
              actions: [
                PopupMenuButton(
                  position: PopupMenuPosition.over,
                  constraints: const BoxConstraints(maxWidth: 150),
                  padding: EdgeInsets.zero,
                  onSelected: (value) {
                    switch (value) {
                      case "end":
                        // _endSession(context);
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      // PopupMenuItem<String>(
                      //   value: 'end',
                      //   height: 30,
                      //   child: Text(
                      //     'End Session',
                      //     style: TextStyle(fontSize: 14.sp),
                      //   ),
                      // ),
                    ];
                  },
                  child: const CircleAvatar(
                      backgroundColor: Pallets.white,
                      foregroundColor: Pallets.black,
                      child: Icon(Icons.more_vert)),
                )
              ],
            ),
            body: Stack(
              children: [
                AppBg(
                  image: Assets.images.pngs.homeBg.path,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                            child: ScrollablePositionedList.builder(
                                reverse: true,
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemScrollController: context
                                    .read<BotChatCubit>()
                                    .scrollController,
                                itemCount: context
                                    .watch<BotChatCubit>()
                                    .stagedMessages
                                    .length,
                                itemBuilder: (context, index) => BCMessageBox(
                                      message: context
                                          .watch<BotChatCubit>()
                                          .stagedMessages
                                          .reversed
                                          .toList()[index],
                                    ))),
                        16.verticalSpace,
                        TalkToMentraInputFields(
                            currentMessage:
                                context.watch<BotChatCubit>().currentQuestion!)

                        // const _InputBar()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
