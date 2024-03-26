import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/end_session_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/feedback_success_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/review_sheet.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/session_ended_sheet.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/talk_to_mentra_message_box.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TalkToMentraScreen extends StatefulWidget {
  const TalkToMentraScreen({Key? key}) : super(key: key);

  @override
  State<TalkToMentraScreen> createState() => _TalkToMentraScreenState();
}

class _TalkToMentraScreenState extends State<TalkToMentraScreen> {
  final List<String> messages = [];
  var bloc = MentraChatBloc(injector.get());

  @override
  void initState() {
    _simulate();
    bloc.add(GetCurrentSessionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MentraChatBloc>(
      create: (context) => bloc,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 90.0),
        //   child: FloatingActionButton(
        //       onPressed: () {}, backgroundColor: Pallets.error),
        // ),
        appBar: CustomAppBar(
          // canGoBack: false,
          // leading: 0.horizontalSpace,
          tittleText: '',
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.over,
              // constraints: const BoxConstraints(maxHeight: 60,),
              constraints: const BoxConstraints(maxWidth: 150),
              padding: EdgeInsets.zero,
              // shape:
              //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onSelected: (value) {
                switch (value) {
                  case "end":
                    _endSession(context);
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
              child: BlocConsumer<MentraChatBloc, MentraChatState>(
                listener: _listenToMentraChatBloc,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                            child: state is GetCurrentSessionFailureState
                                ? Center(
                                    child: AppPromptWidget(
                                      onTap: () {
                                        bloc.add(GetCurrentSessionEvent());
                                      },
                                    ),
                                  )
                                : ScrollablePositionedList.builder(
                                    reverse: true,
                                    itemScrollController: context
                                        .read<MentraChatBloc>()
                                        .scrollController,
                                    // reverse: true,
                                    itemCount: context
                                        .watch<MentraChatBloc>()
                                        .allMessage
                                        .length,
                                    itemBuilder: (context, index) =>
                                        TalkToMentraMessageBox(
                                      message: context
                                          .watch<MentraChatBloc>()
                                          .allMessage
                                          .reversed
                                          .toList()[index],
                                    ),
                                  )),
                        _InputBar()
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _endSession(BuildContext context) async {
    final bool? sessionEnded =
        await CustomDialogs.showBottomSheet(context, const EndSessionDialog(),
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

  void _simulate() async {
    final List<String> myMessages = [
      'Hey Leila! I\'m Mentra, your friendly mental health buddy.\nHow\'s your day going?',
      // "How's your day going?",
      "Hi, Mentra! It's been a bit rough lately. Can you lend an ear?",
      "Absolutely! I'm here to listen and help. What's been bothering you?"
    ];
    for (var message in myMessages) {
      await Future.delayed(
        const Duration(seconds: 1),
      );
      messages.add(message);
      setState(() {});
    }
  }

  void _listenToMentraChatBloc(BuildContext context, MentraChatState state) {
    if (state is RetryMessageFailureState) {
      CustomDialogs.error(state.error);
    }
  }
}

class _InputBar extends StatelessWidget {
  _InputBar({Key? key}) : super(key: key);
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // InkWell(
        //   onTap: () {
        //     _endSession(context);
        //   },
        //   child: const CircleAvatar(
        //     backgroundColor: Pallets.white,
        //     radius: 24,
        //     child: Icon(
        //       Icons.close,
        //       color: Pallets.red,
        //     ),
        //   ),
        // ),
        // 10.horizontalSpace,
        Expanded(
            child: BlocConsumer<MentraChatBloc, MentraChatState>(
          listener: (context, state) {},
          builder: (context, state) {
            return FilledTextField(
                hasBorder: false,
                controller: controller,
                enabled: state is! GetCurrentSessionLoading &&
                    state is! ContinueSessionLoading,
                hasElevation: false,
                suffix: InkWell(
                  onTap: () async {
                    context.read<MentraChatBloc>().add(ContinueSessionEvent(
                        context.read<MentraChatBloc>().sessionId,
                        controller.text));
                  },
                  child: const Icon(
                    Icons.send_rounded,
                    size: 25,
                  ),
                ),
                fillColor: Pallets.white,
                contentPadding: const EdgeInsets.all(16),
                radius: 45,
                hint: 'Message');
          },
        ))
      ],
    );
  }
}
