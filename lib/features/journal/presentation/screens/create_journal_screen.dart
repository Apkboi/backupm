import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/journal/data/models/get_journals_response.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';

class CreateJournalScreen extends StatefulWidget {
  const CreateJournalScreen({super.key, this.prompt, this.journal});

  final GuidedPrompt? prompt;
  final GuidedJournal? journal;

  @override
  State<CreateJournalScreen> createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  final TextEditingController _noteController = TextEditingController();
  final _bloc = JournalBloc(injector.get());

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 300),
      () => _prefillJournal(),
    );
    _prefillJournal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: '',
        actions: [
          CustomNeumorphicButton(
            onTap: () {
              // _delete();
              // // if (selectedImageId == null) {
              _validateAndCreateJournal();
            },
            color: Pallets.primary,
            expanded: false,
            padding: const EdgeInsets.all(12),
            text: 'Save',
          )
        ],
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          SafeArea(
              child: BlocConsumer<JournalBloc, JournalState>(
            bloc: _bloc,
            listener: _listenToJournalBloc,
            builder: (context, state) {
              var prompt = widget.prompt ?? widget.journal?.guidedPrompt;
              return Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  children: [
                    if ( prompt != null)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Pallets.promptMilkCOlor,
                            borderRadius: BorderRadius.circular(10)),
                        width: 1.sw,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: prompt.content,
                              fontWeight: FontWeight.w600,
                              color: Pallets.promptDarkMilkColor,
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: FilledTextField(
                        hint: 'Write your notes here...',
                        fillColor: Colors.transparent,
                        controller: _noteController,
                        hasBorder: false,
                        maxLine: 100,
                      ),
                    )
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  _validateAndCreateJournal() {
    var prompt = widget.prompt ?? widget.journal?.guidedPrompt;

    if (_noteController.text.isNotEmpty) {
      if (widget.journal == null) {
        _bloc.add(CreateJournalEvent(
            body: _noteController.text,
            promptId:
                prompt != null ? prompt!.id.toString() : null));
      } else {
        _bloc.add(UpdateJournalEvent(
            body: _noteController.text,
            promptId:
                prompt != null ?prompt!.id.toString() : null,
            journalId: widget.journal!.id.toString()));
      }
    } else {
      CustomDialogs.error('Journal must not be empty');
    }
  }

  void _listenToJournalBloc(BuildContext context, JournalState state) {
    if (state is CreateJournalLoadingState ||
        state is UpdateJournalLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is CreateJournalFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is CreateJournalSuccessState) {
      context.pop();
      context.pop();
      CustomDialogs.success('Journal Created Successfully');
      injector.get<JournalBloc>().add(GetJournalsEvent());
    }

    if (state is UpdateJournalFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is UpdateJournalSuccessState) {
      context.pop();
      context.pop();
      CustomDialogs.success('Journal Updated Successfully');
      injector.get<JournalBloc>().add(GetJournalsEvent());
    }
  }

  void _prefillJournal() {
    if (widget.journal != null) {
      _noteController.text = widget.journal!.body;
      setState(() {});
    }
  }
}
