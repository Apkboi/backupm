import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
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

class GuidedPromptsScreen extends StatefulWidget {
  const GuidedPromptsScreen({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<GuidedPromptsScreen> createState() => _GuidedPromptsScreenState();
}

class _GuidedPromptsScreenState extends State<GuidedPromptsScreen> {
  final _journalBloc = JournalBloc(injector.get());

  @override
  void initState() {
    _journalBloc.add(GetPromptsEvent(widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Guided Prompt',
      ),
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 23.0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            message: state.error,
                            onTap: () {
                              // logger.i('message');

                              _journalBloc
                                  .add(GetPromptsEvent(widget.categoryId));
                            },
                          ),
                        );
                      }

                      if (state is GetPromptsSuccessState) {
                        if (state.response.data.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              _journalBloc
                                  .add(GetPromptsEvent(widget.categoryId));
                            },
                            child: ListView.builder(
                              itemCount: state.response.data.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: GuidedPromptsItem(
                                  prompt: state.response.data[index],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () async {
                              _journalBloc
                                  .add(GetPromptsEvent(widget.categoryId));
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
      ),
    );
  }

  void _listenToJournalBloc(BuildContext context, JournalState state) {}
}
