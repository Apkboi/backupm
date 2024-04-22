import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/data/models/review_mood_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';

class MentraReviewModel {
  String feeling;
  String comment;

  MentraReviewModel({required this.feeling, required this.comment});
}

class AiReviewSheet extends StatefulWidget {
  const AiReviewSheet({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<AiReviewSheet> createState() => _AiReviewSheetState();
}

class _AiReviewSheetState extends State<AiReviewSheet> {
  final controller = TextEditingController();

  var feeling = 'Happy';

  final bloc = MentraChatBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MentraChatBloc, MentraChatState>(
      listener: _listenToMentraChatBloc,
      bloc: bloc,
      builder: (context, state) {
        return Container(
          color: Pallets.bottomSheetColor,
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 49,
                height: 5,
                decoration: ShapeDecoration(
                  // color: const Color(0xFFBCC4CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
              ),
              10.verticalSpace,
              TextView(
                text: 'How do you feel after this chat?',
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
              25.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    ReviewMoodModel.allMoods.length,
                    (index) => InkWell(
                          onTap: () {
                            feeling = ReviewMoodModel.allMoods[index].mood;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                border: feeling ==
                                        ReviewMoodModel.allMoods[index].mood
                                    ? Border.all(
                                        width: 1, color: Pallets.primary)
                                    : null),
                            child: Column(
                              children: [
                                ImageWidget(
                                    height: 70.h,
                                    width: 70.w,
                                    fit: BoxFit.scaleDown,
                                    onTap: () {
                                      feeling =
                                          ReviewMoodModel.allMoods[index].mood;
                                      setState(() {});
                                    },
                                    imageUrl:
                                        ReviewMoodModel.allMoods[index].avatar),
                                // 5.verticalSpace,
                                // TextView(
                                //   text: ReviewMoodModel.allMoods[index].mood,
                                //   fontSize: 16,
                                // )
                              ],
                            ),
                          ),
                        )),
              ),
              22.verticalSpace,
              Container(
                padding: const EdgeInsets.all(16),
                // height: 300,

                decoration: ShapeDecoration(
                    color: Pallets.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                            color: Colors.grey.withOpacity(
                              0.3,
                            ),
                            width: 0.8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextView(
                      text: 'Review',
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    5.verticalSpace,
                    FilledTextField(
                        // maxLine: 5,
                        minLine: 1,
                        maxLine: 20,
                        hasElevation: false,
                        contentPadding: EdgeInsets.zero,
                        hasBorder: false,
                        // expands: true,
                        controller: controller,
                        fillColor: Colors.transparent,
                        hint: 'Share your thoughts!'),
                  ],
                ),
              ),
              43.verticalSpace,
              CustomNeumorphicButton(
                onTap: () {
                  bloc.add(ReviewMentraSessionEvent(
                      sessionId: widget.sessionId,
                      feeling: feeling,
                      comment: controller.text));
                  // context.pop(MentraReviewModel(
                  //   comment: controller.text,
                  //   feeling: feeling,
                  // ));
                },
                color: Pallets.primary,
                text: "Submit Review",
              ),
              17.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  void _listenToMentraChatBloc(BuildContext context, MentraChatState state) {
    if (state is ReviewMentraLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ReviewMentraSessionSuccessState) {
      context.pop();
      context.pop(true);
      CustomDialogs.success('Thanks for your feedback');

      // CustomDialogs.success('');
    }

    if (state is ReviewMentraSessionFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
