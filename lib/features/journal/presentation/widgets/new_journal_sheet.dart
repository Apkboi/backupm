import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/features/journal/presentation/widgets/guided_prompt_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NewJournalSheet extends StatefulWidget {
  const NewJournalSheet({super.key});

  @override
  State<NewJournalSheet> createState() => _NewJournalSheetState();
}

class _NewJournalSheetState extends State<NewJournalSheet> {
  final _journalBloc = JournalBloc(injector.get());

  @override
  void initState() {
    _journalBloc.add(GetPromptsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoScaffold(body: Container()),
        CupertinoScaffold(
          transitionBackgroundColor: Pallets.bottomSheetColor,
          // backgroundColor: Pallets.bottomSheetColor,
          // topRadius: Radius.circular(50),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Pallets.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                16.verticalSpace,
                CustomNeumorphicButton(
                  onTap: () {
                    context.pop();
                    context.pushNamed(
                      PageUrl.createJournalScreen,
                    );
                  },
                  color: Pallets.primary,
                  child: Row(
                    children: [
                      ImageWidget(imageUrl: Assets.images.svgs.editFilled),
                      5.horizontalSpace,
                      const TextView(
                        text: 'Blank Entry',
                        color: Pallets.white,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                const TextView(
                  text: 'Guided Prompts',
                  fontSize: 16,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w600,
                ),
                20.verticalSpace,
                Expanded(
                    child: BlocConsumer<JournalBloc, JournalState>(
                  listener: _listenToJournalBloc,
                  bloc: _journalBloc,
                  builder: (context, state) {
                    if (state is GetPromptsLoadingState) {
                      return Center(
                        child: CustomDialogs.getLoading(size: 30),
                      );
                    }

                    if (state is GetPromptsFailureState) {
                      return Center(
                        child: AppPromptWidget(
                          onTap: () {
                            _journalBloc.add(GetPromptsEvent());
                          },
                        ),
                      );
                    }

                    if (state is GetPromptsSuccessState) {
                      if (state.response.data.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            _journalBloc.add(GetPromptsEvent());
                          },
                          child: ListView.builder(
                            itemCount: state.response.data.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GuidedPromptsItem(
                                prompt: state.response.data[index],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            _journalBloc.add(GetPromptsEvent());
                          },
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                AppEmptyState(
                                  hasBg: false,
                                  tittleColor: Pallets.black,
                                  image: Assets.images.pngs.journalNote.path,
                                ),
                                // Spacer(),
                              ],
                            ),
                          ),
                        );
                      }
                    }

                    return Container();
                  },
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _listenToJournalBloc(BuildContext context, JournalState state) {}
}
