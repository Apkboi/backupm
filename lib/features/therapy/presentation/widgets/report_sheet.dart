import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';

// class MentraReviewModel {
//   String feeling;
//   String comment;
//
//   MentraReviewModel({required this.feeling, required this.comment});
// }

class ReportSheet extends StatefulWidget {
  const ReportSheet({Key? key}) : super(key: key);

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  final controller = TextEditingController();

  var feeling = 'Happy';
  final _therapyBloc = TherapyBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallets.bottomSheetColor,
      padding: const EdgeInsets.all(18),
      child: BlocConsumer<TherapyBloc, TherapyState>(
        bloc: _therapyBloc,
        listener: _listenToTherapyBloc,
        builder: (context, state) {
          return Column(
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
                text: 'Report inappropriate content here',
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                    fontSize: 18.sp, fontWeight: FontWeight.w600),
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
                      text: 'Report',
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
                        hint: 'Describe the issue you want to report'),
                  ],
                ),
              ),
              35.verticalSpace,
              CustomNeumorphicButton(
                expanded: false,
                padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 14.h),
                onTap: () {
                  // if(){}
                  _therapyBloc.add(ReportEvent(controller.text));
                  // context.pop(MentraReviewModel(
                  //   comment: controller.text,
                  //   feeling: feeling,
                  // ));
                },
                color: Pallets.primary,
                text: "Report",
              ),
              17.verticalSpace,
            ],
          );
        },
      ),
    );
  }

  void _listenToTherapyBloc(BuildContext context, TherapyState state) {
    if (state is ReportLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ReportSuccessState) {
      context.pop();
      context.pop();
      // context.pop(true);
      CustomDialogs.success('Report sent successfully');
    }
    if (state is ReportFailureState) {
      context.pop();
      // context.pop(true);
      CustomDialogs.error(state.error);
    }
  }
}
