import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/preference_message_base_box.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UserPreferenceScreen extends StatefulWidget {
  const UserPreferenceScreen({super.key, required this.flow});

  final UserPreferenceFlow flow;

  @override
  State<UserPreferenceScreen> createState() => _UserPreferenceScreenState();
}

class _UserPreferenceScreenState extends State<UserPreferenceScreen> {
  final userPreferenceBloc = UserPreferenceCubit(injector.get());

  @override
  void initState() {
    userPreferenceBloc.startMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userPreferenceBloc,
      lazy: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(
          // canGoBack: false,
          // leading: 0.horizontalSpace,
          tittleText: '',
        ),
        body: BlocConsumer<UserPreferenceCubit, UserPreferenceState>(
          listener: (context, state) {
            if (state is UpdatePreferenceLoadingState) {
              CustomDialogs.showLoading(context);
            }
            if (state is UpdatePreferenceFailureState) {
              context.pop();
              CustomDialogs.error(state.error);
            }
            if (state is UpdatePreferenceSuccessState) {
              context.pop();
              CustomDialogs.success(state.response.message);
              if (widget.flow == UserPreferenceFlow.signup) {
                context.goNamed(PageUrl.homeScreen);
              }

              if (widget.flow == UserPreferenceFlow.updatePreference) {
                context.pop();
              }
              if (widget.flow == UserPreferenceFlow.changeTherapist ||
                  widget.flow == UserPreferenceFlow.selectTherapist) {
                // context.pop();
                context.pushReplacementNamed(PageUrl.matchTherapistScreen,
                    queryParameters: {PathParam.updatedPreference: 'true'});
              }
            }
          },
          builder: (context, state) {
            return Stack(
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
                              .read<UserPreferenceCubit>()
                              .scrollController,
                          itemCount: context
                              .watch<UserPreferenceCubit>()
                              .stagedMessages
                              .length,
                          itemBuilder: (context, index) =>
                              PreferenceQuestionBaseBox(
                            question: context
                                .watch<UserPreferenceCubit>()
                                .stagedMessages
                                .reversed
                                .toList()[index],
                          ),
                        )),
                        _InputBar(
                          currentFlow: widget.flow,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InputBar extends StatefulWidget {
  _InputBar({Key? key, required this.currentFlow}) : super(key: key);
  final UserPreferenceFlow currentFlow;

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserPreferenceCubit>();
    return BlocConsumer(
        bloc: bloc,
        builder: (context, state) {
          if (state is QuestionsCompletedState) {
            // if (currentFlow == UserPreferenceFlow.signup ||
            //     currentFlow == UserPreferenceFlow.updatePreference) {
            return CustomNeumorphicButton(
              onTap: () {
                bloc.updatePreferences(
                    bloc.convertQuestionsToMap(bloc.stagedMessages));
              },
              color: Pallets.primary,
              text: 'Done',
            );
            // }
          }

          return bloc.currentQuestion!.options.isEmpty
              ? Row(
                  children: [
                    Expanded(
                        child: FilledTextField(
                            hasBorder: false,
                            hasElevation: false,
                            controller: controller,
                            suffix: InkWell(
                              onTap: () async {
                                _answerQuestion(context);
                              },
                              child: const Icon(
                                Icons.send_rounded,
                                size: 30,
                              ),
                            ),
                            onChanged: (p0) {
                              // setState(() {});
                              return null;
                            },
                            // suffix: ImageWidget(
                            //   imageUrl: Assets.images.svgs.share,
                            //   height: 20,
                            //   width: 20,
                            // ),
                            fillColor: Pallets.white,
                            contentPadding: const EdgeInsets.all(16),
                            radius: 45,
                            hint: 'Message')),
                    // 10.horizontalSpace,
                    // InkWell(
                    //   onTap: () {
                    //     _answerQuestion(context);
                    //     // _endSession(context);
                    //   },
                    //   child: CircleAvatar(
                    //       backgroundColor: Pallets.white,
                    //       radius: 24,
                    //       child: ImageWidget(
                    //           color: controller.text.isNotEmpty
                    //               ? Pallets.primary
                    //               : null,
                    //           imageUrl: Assets.images.svgs.messageIcon)),
                    // )
                  ],
                )
              : 0.horizontalSpace;
        },
        buildWhen: _buildWhen,
        listener: _listenToUserPreferenceBloc);
  }

  void _answerQuestion(BuildContext context) {
    if (controller.text.isNotEmpty) {
      context.read<UserPreferenceCubit>().answerQuestion(
          id: context.read<UserPreferenceCubit>().currentQuestion?.id ?? -1,
          answer: controller.text.trim());
      controller.clear();
    }
  }

  void _listenToUserPreferenceBloc(BuildContext context, Object? state) {
    if (state is QuestionsCompletedState &&
        widget.currentFlow == UserPreferenceFlow.changeTherapist) {}
  }

  bool _buildWhen(Object? previous, Object? current) {
    return current is QuestionsCompletedState ||
        current is QuestionUpdatedState;
  }
}
