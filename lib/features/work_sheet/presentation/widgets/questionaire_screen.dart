import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/work_sheet/data/models/get_questions_response.dart';
import 'package:mentra/features/work_sheet/data/models/submit_questionaire_payload.dart';
import 'package:mentra/features/work_sheet/presentation/blocs/worksheet/worksheet_bloc.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/questionaire_field.dart';
import 'package:mentra/gen/assets.gen.dart';

class QuestionaireScreen extends StatefulWidget {
  const QuestionaireScreen({super.key, required this.id, required this.name});

  final String id;
  final String name;

  @override
  State<QuestionaireScreen> createState() => _QuestionaireScreenState();
}

class _QuestionaireScreenState extends State<QuestionaireScreen> {
  List<TextEditingController> allControllers = [];
  List<Questionaire> allQuestionaires = [];
  final _bloc = WorkSheetBloc(injector.get());

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    _bloc.add(GetQuestionairesEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallets.white,
        foregroundColor: Pallets.black,
        flexibleSpace: 20.verticalSpace,
        elevation: 0,
        centerTitle: true,
        leading: HapticInkWell(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageWidget(
              imageUrl: Assets.images.svgs.arrowLeft,
              size: 16,
              height: 25,
              width: 25,
              onTap: () {
                context.pop();
              },
            ),
          ),
        ),
        title: TextView(
          text: widget.name,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Form(
        key: _key,
        child: Stack(
          children: [
            const AppBg(),
            Column(
              children: [
                Expanded(
                    child: BlocConsumer<WorkSheetBloc, WorkSheetState>(
                  bloc: _bloc,
                  buildWhen: _buildWhen,
                  listener: _listenToWorkSheetBloc,
                  builder: (context, state) {
                    if (state is GetQuestionaireLoadingState) {
                      return Center(
                        child: CustomDialogs.getLoading(size: 30),
                      );
                    }

                    if (state is GetQuestionairesSuccessState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.response.data.length,
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: QuestionaireField(
                                  controller: allControllers[index],
                                  question: state.response.data[index].question,
                                  submitted:
                                      state.response.data[index].answer != null,
                                ),
                              ),
                            ),
                            if (state.response.data
                                .any((element) => element.answer == null))
                              CustomNeumorphicButton(
                                  onTap: () {
                                    _submitQuestionaire();
                                  },
                                  color: Pallets.primary,
                                  text: "Submit"),
                            30.verticalSpace,
                          ],
                        ),
                      );
                    }
                    if (state is WorkSheetFailureState) {
                      return AppPromptWidget(
                        onTap: () {
                          _bloc.add(GetQuestionairesEvent(widget.id));
                        },
                      );
                    }

                    return 0.verticalSpace;
                  },
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _listenToWorkSheetBloc(BuildContext context, WorkSheetState state) {
    if (state is GetQuestionairesSuccessState) {
      allControllers = List.generate(
          state.response.data.length, (index) => TextEditingController());
      allQuestionaires = state.response.data;
      for (var i = 0; i <= allQuestionaires.length-1; i++) {
        allControllers[i].text = allQuestionaires[i].answer;
        setState(() {});
      }
    }

    if (state is SubmitQuestionaireFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is SubmitQuestionairesSuccessState) {
      context.pop();
      CustomDialogs.success("Questions submitted successfully");
      _bloc.add(GetQuestionairesEvent(widget.id));
    }
    if (state is SubmitQuestionaireLoadingState) {
      CustomDialogs.showLoading(context);
    }
  }

  void _submitQuestionaire() {
    if (_key.currentState?.validate() ?? false) {
      var payload = SubmitQuestionairePayload(
          worksheetId: widget.id,
          data: List.generate(
              allQuestionaires.length,
              (index) => QuestionaireAnswer(
                  worksheetQuestionId: allQuestionaires[index].id,
                  answer: allControllers[index].text)));
      logger.w(payload.toJson());
      _bloc.add(SubmitQuestionairesEvent(payload));
    }
  }

  bool _buildWhen(WorkSheetState previous, WorkSheetState current) {
    return current is GetQuestionaireLoadingState ||
        current is GetQuestionairesSuccessState ||
        current is GetQuestionaireFailedState;
  }
}
