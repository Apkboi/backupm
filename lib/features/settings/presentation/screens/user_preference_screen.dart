import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/widgets/user_preference/preference_message_base_box.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UserPreferenceScreen extends StatefulWidget {
  const UserPreferenceScreen({Key? key}) : super(key: key);

  @override
  State<UserPreferenceScreen> createState() => _UserPreferenceScreenState();
}

class _UserPreferenceScreenState extends State<UserPreferenceScreen> {
  final userPreferenceBloc = UserPreferenceCubit();

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
            // TODO: implement listener
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
                        _InputBar()
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

class _InputBar extends StatelessWidget {
  _InputBar({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserPreferenceCubit>();
    return bloc.currentQuestion!.options.isEmpty
        ? Row(
            children: [
              Expanded(
                  child: FilledTextField(
                      hasBorder: false,
                      hasElevation: false,
                      controller: controller,
                      // suffix: ImageWidget(
                      //   imageUrl: Assets.images.svgs.share,
                      //   height: 20,
                      //   width: 20,
                      // ),
                      fillColor: Pallets.white,
                      contentPadding: const EdgeInsets.all(16),
                      radius: 45,
                      hint: 'Message')),
              10.horizontalSpace,
              InkWell(
                onTap: () {
                  _answerQuestion(context);
                  // _endSession(context);
                },
                child: CircleAvatar(
                    backgroundColor: Pallets.white,
                    radius: 24,
                    child:
                        ImageWidget(imageUrl: Assets.images.svgs.messageIcon)),
              )
            ],
          )
        : 0.horizontalSpace;
  }

  void _answerQuestion(BuildContext context) {
    if (controller.text.isNotEmpty) {
      context.read<UserPreferenceCubit>().answerQuestion(
          id: context.read<UserPreferenceCubit>().currentQuestion?.id ?? -1,
          answer: controller.text.trim());
    }
  }
}
