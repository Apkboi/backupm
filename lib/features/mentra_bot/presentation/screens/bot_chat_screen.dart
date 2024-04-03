import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_message_box.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/talk_to_mentra_input_fields.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/end_session_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/feedback_success_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/review_sheet.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/session_ended_sheet.dart';
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
    botChatCubit.displayWelcomeMessages(BotChatFlow.welcome);
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
          // var _shouldShowBotIcon =
          //     context.watch<BotChatCubit>().currentChatFlow ==
          //             BotChatFlow.welcome &&
          //         context.watch<BotChatCubit>().stagedMessages.length < 3;
          // context.watch<BotChatCubit>();
          return WillPopScope(
            onWillPop: () async {
              if (SessionManager.instance.isLoggedIn) {
                context.pushNamed(PageUrl.homeScreen);
              } else {
                context.pop();
              }
              return false;
            },
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: CustomAppBar(
                tittleText: '',
                leading: CustomBackButton(
                  icon: context.watch<BotChatCubit>().canNotRevert
                      ? null
                      : const Icon(
                          Icons.undo,
                          color: Pallets.black,
                        ),
                  onTap: () {
                    // context.pop(context);
                    _goBack(context);
                  },
                ),
                actions: [
                  PopupMenuButton(
                    position: PopupMenuPosition.over,
                    constraints: const BoxConstraints(maxWidth: 150),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    onSelected: (value) {
                      switch (value) {
                        case "end":
                          if (SessionManager.instance.isLoggedIn) {
                            // _endSession(context);
                          } else {
                            context.pop();
                          }
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'end',
                          height: 30,
                          child: Text(
                            'End Session',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
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

                                  // shrinkWrap: true,

                                  // addAutomaticKeepAlives: true,
                                  padding: EdgeInsets.zero,
                                  // physics:
                                  //     const AlwaysScrollableScrollPhysics(),
                                  itemScrollController: context
                                      .read<BotChatCubit>()
                                      .scrollController,
                                  itemCount: context
                                      .watch<BotChatCubit>()
                                      .stagedMessages
                                      .reversed
                                      .toList()
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
                              currentMessage: context
                                  .watch<BotChatCubit>()
                                  .currentQuestion!)

                          // const _InputBar()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _goBack(BuildContext context) {
    if (context.read<BotChatCubit>().canNotRevert) {
      if (SessionManager.instance.isLoggedIn) {
        context.pushNamed(PageUrl.homeScreen);
      } else {
        context.pop();
      }
    } else {
      context.read<BotChatCubit>().revertBack();
    }
  }

  void _endSession(BuildContext context) async {
    final bool? sessionEnded = await CustomDialogs.showBottomSheet(
        context, const EndMentraSessionDialog(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        constraints: BoxConstraints(maxHeight: 0.9.sh));

    if (sessionEnded ?? false) {
      final bool? writeReview = await CustomDialogs.showBottomSheet(
          context, const MentraSessionEndedSheet(),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          constraints: BoxConstraints(maxHeight: 0.9.sh));

      if (writeReview ?? false) {
        final bool? wroteFeedback =
            await CustomDialogs.showBottomSheet(context, const ReviewSheet(),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
                constraints: BoxConstraints(maxHeight: 0.9.sh));

        if (wroteFeedback ?? false) {
          await CustomDialogs.showBottomSheet(
              context, const FeedbackSuccessDialog(),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
              constraints: BoxConstraints(maxHeight: 0.9.sh));
          context.pop();
        }
        context.pop();
      } else {
        context.pop();
      }
    }
  }
}
