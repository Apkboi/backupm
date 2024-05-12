import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';

import '../../data/models/incoming_response.dart';

class TherapyReviewSheet extends StatefulWidget {
  const TherapyReviewSheet(
      {super.key, required this.sessionId, required this.therapist});

  final String sessionId;
  final Caller therapist;

  @override
  State<TherapyReviewSheet> createState() => _TherapyReviewSheetState();
}

class _TherapyReviewSheetState extends State<TherapyReviewSheet> {
  final _therapyBloc = TherapyBloc(injector.get());

  double sessionRating = 3;
  double audioRating = 3;
  double videoRating = 3;

  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TherapyBloc, TherapyState>(
      bloc: _therapyBloc,
      listener: _listenToTherapyBloc,
      builder: (context, state) {
        return Container(
          color: Pallets.bottomSheetColor,
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 49,
                  height: 5,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                    ),
                  ),
                ),
                10.verticalSpace,
                TextView(
                  text:
                      "Please rate your session with ${widget.therapist.name}?",
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
                const TextView(
                  text: 'Rate Audio',
                  align: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  color: Pallets.ink,
                ),
                10.verticalSpace,
                RatingWiget(onRatingUpdate: (rating) {
                  audioRating = rating;
                }),
                20.verticalSpace,
                const TextView(
                  text: 'Rate Video',
                  align: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  color: Pallets.ink,
                ),
                10.verticalSpace,
                RatingWiget(onRatingUpdate: (rating) {
                  videoRating = rating;
                }),
                20.verticalSpace,
                const TextView(
                  text: 'Rate Session',
                  align: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  color: Pallets.ink,
                ),
                10.verticalSpace,
                RatingWiget(onRatingUpdate: (rating) {
                  sessionRating = rating;
                }),
                22.verticalSpace,
                Form(
                  key: _formKey,
                  child: Container(
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
                        // TextView(
                        //   text: 'Review',
                        //   style: GoogleFonts.inter(
                        //       fontSize: 12, fontWeight: FontWeight.w500),
                        // ),
                        // 5.verticalSpace,
                        FilledTextField(
                            // maxLine: 5,
                            minLine: 1,
                            maxLine: 20,
                            hasElevation: false,
                            contentPadding: EdgeInsets.zero,
                            hasBorder: false,
                            // expands: true,
                            controller: _reviewController,
                            fillColor: Colors.transparent,
                            hint:
                                'Write your review here. What did you like? What could be improved?'),
                      ],
                    ),
                  ),
                ),
                43.verticalSpace,
                CustomNeumorphicButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _therapyBloc.add(CreateReviewEvent(
                          sessionId: widget.sessionId.toString(),
                          comment: _reviewController.text,
                          audioRating: audioRating.round(),
                          videoRating: videoRating.round(),
                          sessionRating: sessionRating.round()));
                    }
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
          ),
        );
      },
    );
  }

  void _listenToTherapyBloc(BuildContext context, TherapyState state) {
    if (state is CreateReviewLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is CreateReviewFailureState) {
      CustomDialogs.hideLoading(context);
    }
    if (state is CreateReviewSuccessState) {
      context.pop();
      context.pop(true);

      // CustomDialogs.success('');
    }
  }
}

class RatingWiget extends StatelessWidget {
  const RatingWiget({
    super.key,
    required this.onRatingUpdate,
  });

  final Function(double) onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      itemSize: 50,
      direction: Axis.horizontal,
      allowHalfRating: false,
      glow: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Container(
        decoration: ShapeDecoration(
            // color: Pallets.white,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                    color: Colors.grey.withOpacity(
                      0.5,
                    ),
                    width: 0.5))),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Icon(
            Icons.star_rounded,
            color: Pallets.yellowBase,
            size: 50,
            // size: 18,
          ),
        ),
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
