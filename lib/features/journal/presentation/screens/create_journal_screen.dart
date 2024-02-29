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
              return Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  children: [
                    if (widget.prompt != null)
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
                              text: widget.prompt!.content,
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
    if (_noteController.text.isNotEmpty) {
      if (widget.journal == null) {
        _bloc.add(CreateJournalEvent(
            body: _noteController.text,
            promptId:
                widget.prompt != null ? widget.prompt!.id.toString() : null));
      } else {
        //   TODO EDIT JOURNAL
      }
    } else {
      CustomDialogs.error('Journal must not be empty');
    }
  }

  void _listenToJournalBloc(BuildContext context, JournalState state) {
    if (state is CreateJournalLoadingState) {
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
  }

  void _prefillJournal() {
    if (widget.journal != null) {
      _noteController.text = widget.journal!.body;
    }
  }
}
