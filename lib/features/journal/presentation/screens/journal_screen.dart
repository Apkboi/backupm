import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/features/journal/presentation/widgets/jornal_item.dart';
import 'package:mentra/features/journal/presentation/widgets/guided_prompts_screen.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';


class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  // final _journalBloc = JournalBloc(injector.get());

  @override
  void initState() {
    _getJournals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: CustomNeumorphicButton(
          padding: const EdgeInsets.all(16),
          onTap: () {
            context.pushNamed(PageUrl.promptsCategoryScreen);
          },
          color: Pallets.primary,
          expanded: false,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Pallets.white,
          ),
        ),
      ),
      appBar: CustomAppBar(
        centerTile: false,
        // canGoBack: false,
        leading: 0.horizontalSpace,
        leadingWidth: 0,
        tittle: TextView(
          text: 'Journal',
          style: GoogleFonts.fraunces(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark),
        ),
        actions: [
          HapticInkWell(
            onTap: () {
              context.goNamed(PageUrl.menuScreen);
            },
            child: CircleAvatar(
              backgroundColor: Pallets.white,
              radius: 25,
              child: ImageWidget(imageUrl: Assets.images.svgs.menuIcon),
            ),
          ),
          16.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                children: [
                  Expanded(
                      child: BlocConsumer<JournalBloc, JournalState>(
                    buildWhen: _buildWhen,
                    listener: _listenToJournalBloc,
                    bloc: injector.get<JournalBloc>(),
                    builder: (context, state) {
                      if (state is GetJournalsLoadingState) {
                        return Center(
                          child: CustomDialogs.getLoading(size: 30),
                        );
                      }

                      if (state is GetJournalsFailureState) {
                        return Center(
                          child: AppPromptWidget(
                            onTap: () {
                              injector
                                  .get<JournalBloc>()
                                  .add(GetJournalsEvent());
                            },
                          ),
                        );
                      }

                      // if (state is GetJournalsSuccessState) {
                      if (injector.get<JournalBloc>().journals?.isNotEmpty ??
                          false) {
                        var journals = injector.get<JournalBloc>().journals;
                        return RefreshIndicator(
                          onRefresh: () async {
                            injector.get<JournalBloc>().add(GetJournalsEvent());
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: journals?.length ?? 0,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) =>
                                  AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: JournalItem(
                                        journal: journals![index],
                                        // prompt: state.response.data[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            injector.get<JournalBloc>().add(GetJournalsEvent());
                          },
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                AppEmptyState(
                                  hasBg: false,
                                  tittleColor: Pallets.black,
                                  tittle: 'Start journaling today ',
                                  subtittle:
                                      'Take a moment to pause, reflect, and explore the depths of your inner world. Begin your journaling journey today.',
                                  image: Assets.images.pngs.journalNote.path,
                                ),
                                // Spacer(),
                              ],
                            ),
                          ),
                        );
                      }
                      // }

                      return Container();
                    },
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listenToJournalBloc(BuildContext context, JournalState state) {
    if (state is DeleteJournalsLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is DeleteJournalsFailureState) {
      context.pop();

      CustomDialogs.error(state.error);
    }
    if (state is DeleteJournalsSuccessState) {
      context.pop();
      CustomDialogs.showBottomSheet(
          context,
          SuccessDialog(
            tittle: "Journal Entry has been successfully deleted.",
            onClose: () {
              context.pop();
            },
          ));
      injector.get<JournalBloc>().add(GetJournalsEvent());
    }
  }

  bool _buildWhen(JournalState previous, JournalState current) {
    return current is GetJournalsLoadingState ||
        current is GetJournalsFailureState ||
        current is GetJournalsSuccessState;
  }

  void _getJournals() {
    if (injector.get<JournalBloc>().journals == null) {
      injector.get<JournalBloc>().add(GetJournalsEvent());
    }
  }
}
