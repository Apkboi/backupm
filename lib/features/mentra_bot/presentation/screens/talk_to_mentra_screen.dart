import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/continue_chat_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/end_session_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/review_sheet.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/talk_to_mentra_message_box.dart';
import 'package:mentra/features/therapy/presentation/widgets/report_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TalkToMentraScreen extends StatefulWidget {
  const TalkToMentraScreen({Key? key, required this.authMessages})
      : super(key: key);
  final List<MentraChatModel> authMessages;

  @override
  State<TalkToMentraScreen> createState() => _TalkToMentraScreenState();
}

class _TalkToMentraScreenState extends State<TalkToMentraScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> messages = [];
  bool restartSession = false;

  var bloc = MentraChatBloc(injector.get());

  @override
  void initState() {
    logger.i(widget.authMessages.length);
    bloc.add(AddAuthMessagesEvent(widget.authMessages));
    Future.delayed(
      Duration(seconds: widget.authMessages.isNotEmpty ? 1 : 0),
      () {
        bloc.add(GetCurrentSessionEvent());
      },
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.goNamed(PageUrl.homeScreen);

        return true;
      },
      child: BlocProvider<MentraChatBloc>(
        create: (context) => bloc,
        child: Scaffold(
          extendBodyBehindAppBar: true,

          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 90.0),
          //   child: FloatingActionButton(
          //       onPressed: () {}, backgroundColor: Pallets.error),
          // ),

          appBar: CustomAppBar(
            tittleText: '',
            onBackPressed: () {
              context.goNamed(PageUrl.homeScreen);
            },
            actions: [
              PopupMenuButton(
                position: PopupMenuPosition.over,
                // constraints: const BoxConstraints(maxHeight: 60,),
                constraints: const BoxConstraints(maxWidth: 110),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
                onSelected: (value) {
                  switch (value) {
                    case "end":
                      _endSession(context);
                    case "report":
                      _report();
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
                    PopupMenuItem<String>(
                      value: 'report',
                      height: 30,
                      child: Text(
                        'Report',
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
                  bloc: bloc,
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
                                      padding: EdgeInsets.zero,
                                      itemScrollController: context
                                          .read<MentraChatBloc>()
                                          .scrollController,
                                      // reverse: true,
                                      itemCount: context
                                          .watch<MentraChatBloc>()
                                          .allMessages
                                          .length,
                                      itemBuilder: (context, index) =>
                                          TalkToMentraMessageBox(
                                        message: context
                                            .watch<MentraChatBloc>()
                                            .allMessages
                                            .reversed
                                            .toList()[index],
                                      ),
                                    )),
                          16.verticalSpace,
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
      ),
    );
  }

  void _showContinueSessionPrompt(BuildContext context) async {
    final bool? endSession =
        await CustomDialogs.showBottomSheet(context, const ContinueChatDialog(),
            transitionAnimationController: _controller,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            constraints: BoxConstraints(maxHeight: 0.9.sh));

    if (endSession ?? false) {
      restartSession = true;
      bloc.add(EndMentraSessionEvent(bloc.sessionId));
    }
  }

  void _endSession(BuildContext context, {bool restart = false}) async {
    final bool? sessionEnded = await CustomDialogs.showBottomSheet(
        context, const EndMentraSessionDialog(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        constraints: BoxConstraints(maxHeight: 0.9.sh));

    if (sessionEnded ?? false) {
      final MentraReviewModel? review = await CustomDialogs.showCustomDialog(
        ReviewSheet(),
        context,
      );

      if (review != null) {
        bloc.add(EndMentraSessionEvent(bloc.sessionId,
            feeling: review.feeling, comment: review.comment));
      }
    } else {
      restartSession = false;
    }
  }

  void goBack(BuildContext context, {bool restart = false}) {
    if (!restart) {
      context.pop();
    }
  }

  Future<void> _listenToMentraChatBloc(
      BuildContext context, MentraChatState state) async {
    if (state is GetCurrentSessionSuccessState) {
      if (!state.response.data.isNew) {
        _showContinueSessionPrompt(context);
      }
    }
    if (state is RetryMessageFailureState) {
      CustomDialogs.error(state.error);
    }

    if (state is EndMentraSessionLoading) {
      CustomDialogs.showLoading(context);
    }
    if (state is EndMentraSessionnSuccessState) {
      context.pop();

      if (!restartSession) {
        CustomDialogs.success('Thank you for your feedback.');
        context.goNamed(PageUrl.homeScreen);
      } else {
        bloc.add(GetCurrentSessionEvent());
      }
    }

    if (state is EndMentraSessionFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  void _report() async {
    final MentraReviewModel? review = await CustomDialogs.showCustomDialog(
      const ReportSheet(),
      context,
    );
  }
}

class _InputBar extends StatelessWidget {
  _InputBar({Key? key}) : super(key: key);
  final controller = TextEditingController();

  bool _enableTextField(MentraChatState state) =>
      !(state is GetCurrentSessionLoading ||
          state is ContinueSessionLoading ||
          state is GetCurrentSessionFailureState ||
          state is ContinueSessionFailureState);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: BlocConsumer<MentraChatBloc, MentraChatState>(
          bloc: context.read(),
          listener: (context, state) {
            logger.i(_enableTextField(state));
          },
          builder: (context, state) {
            return FilledTextField(
                hasBorder: false,
                controller: controller,
                enabled: _enableTextField(state),
                hasElevation: false,
                minLine: 1,
                maxLine: 5,
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
