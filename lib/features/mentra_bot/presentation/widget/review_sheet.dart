import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/review_mood_model.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';

class MentraReviewModel {
  String feeling;
  String comment;

  MentraReviewModel({required this.feeling, required this.comment});
}

class ReviewSheet extends StatefulWidget {
  const ReviewSheet({Key? key}) : super(key: key);

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  final controller = TextEditingController();

  var feeling = 'Happy';

  @override
  Widget build(BuildContext context) {
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
            text: 'How Do You Feel After Our Chat Today?',
            align: TextAlign.center,
            style: GoogleFonts.fraunces(
                fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          22.verticalSpace,
          const TextView(
            text: reviewSubtext,
            align: TextAlign.center,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Pallets.ink,
          ),
          20.verticalSpace,
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
                            borderRadius: BorderRadius.circular(10.r),
                            border: feeling ==
                                    ReviewMoodModel.allMoods[index].mood
                                ? Border.all(width: 1, color: Pallets.secondary)
                                : null),
                        child: Column(
                          children: [
                            ImageWidget(
                                size: 50,
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: 'Review',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                7.verticalSpace,

                // const TextField(
                //   // expands: true,
                //   maxLines: null,
                //   // minLines: null,
                //   decoration: InputDecoration(constraints: BoxConstraints(maxHeight: 20,minHeight: 19)),
                // )
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
                    hint:
                        'Share your thoughts! How did Mentra support you today? Your words make a difference.'),
              ],
            ),
          ),
          43.verticalSpace,
          CustomNeumorphicButton(
            onTap: () {
              context.pop(MentraReviewModel(
                comment: controller.text,
                feeling: feeling,
              ));

              // context.pop();
              // CustomDialogs.showBottomSheet(
              //     context, const EndSessionDialog(),
              //     shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(16),
              //           topRight: Radius.circular(16),
              //         )),
              //     constraints: BoxConstraints(maxHeight: 0.9.sh));
            },
            color: Pallets.primary,
            text: "Submit Review",
          ),
          17.verticalSpace,
        ],
      ),
    );
  }

  void _listenToTherapyBloc(BuildContext context, TherapyState state) {
    if (state is CreateReviewLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is CreateReviewSuccessState) {
      context.pop();
      context.pop(true);

      // CustomDialogs.success('');
    }
  }
}
