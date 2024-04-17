import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/widgets/cancel_session_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_date_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_time_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/session_ended_dialog.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_review_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'end_therapy_session_dialog.dart';

class TherapyDetailsSheet extends StatefulWidget {
  const TherapyDetailsSheet({super.key, required this.session});

  final TherapySession session;

  @override
  State<TherapyDetailsSheet> createState() => _TherapyDetailsSheetState();
}

class _TherapyDetailsSheetState extends State<TherapyDetailsSheet> {

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      transitionBackgroundColor: Pallets.bottomSheetColor,
      // backgroundColor: Pallets.bottomSheetColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              ImageWidget(
                imageUrl: widget.session.therapist.user.avatar,
                height: 64.h,
                width: 64.w,
                borderRadius: BorderRadius.circular(30),
              ),
              6.verticalSpace,
              TextView(
                text: widget.session.focus,
                style: GoogleFonts.fraunces(
                    color: Pallets.navy,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600),
              ),
              8.verticalSpace,
              TextView(
                  text: 'Session with ${widget.session.therapist.user.name}',
                  color: Pallets.brandColor,
                  fontWeight: FontWeight.w600),
              17.verticalSpace,
              Row(
                children: [
                  CustomNeumorphicButton(
                      fgColor: Pallets.black,
                      expanded: false,
                      padding: const EdgeInsets.all(10),
                      onTap: () async {
                        // injector.get<MesiboCubit>().startGroupCall();
                        // _startMessaging();
                        context.pushNamed(PageUrl.therapistChatScreen);
                      },
                      text: "Message ${widget.session.therapist.user.name}",
                      color: Pallets.milkColor),
                  8.horizontalSpace,
                  CustomOutlinedButton(
                    bgColor: Colors.white,
                    outlinedColr: Pallets.primary,

                    padding: const EdgeInsets.all(10),
                    isExpanded: false,
                    radius: 148,
                    child: const TextView(
                      text: 'Cancel Session',
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      _cancelTherapySession(context);
                    },
                  ),
                ],
              ),
              48.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextView(
                      text: 'Status',
                      color: Pallets.ink,
                    ),
                    TextView(
                      text: widget.session.status,
                      color: Pallets.mildOrange,
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: 'Date',
                          color: Pallets.ink,
                        ),
                        TextView(
                          text: TimeUtil.formatDate(
                              widget.session.startsAt.toIso8601String()),
                          // color: Pallets.mildOrange,
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextView(
                          text: 'Time',
                          color: Pallets.ink,
                        ),
                        TextView(
                          text: TimeUtil.formatTime(widget.session.startsAt),
                          // color: Pallets.mildOrange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                    color: Pallets.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: 'Your notes',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    TextView(
                      text: widget.session.note ?? '',
                    ),
                  ],
                ),
              ),
              77.verticalSpace,
              Center(
                child: CustomNeumorphicButton(
                  onTap: () {
                    // _endSession(context);
                    _reScheduleTherapy(context);
                  },
                  color: Pallets.primary,
                  expanded: false,
                  text: "Reschedule Session",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _reScheduleTherapy(BuildContext context) {
    // context.pop();
    injector.get<TherapyBloc>().currentSessionFlow = SessionFlow.reSchedule;
    CustomDialogs.showCupertinoBottomSheet(context, SelectDateSheet(
      onSelected: (DateTime selectedDate) {
        injector.get<TherapyBloc>().updatePayload(
            date: selectedDate, sessionId: widget.session.id.toString());

        CustomDialogs.showCupertinoBottomSheet(
          context,
          SelectTimeSheet(
            date: selectedDate,
          ),
        );
      },
    ), useRootNavigator: true);
  }

  void _cancelTherapySession(BuildContext context) async {
    final bool? canceled = await CustomDialogs.showCupertinoBottomSheet(
      context,
      CancelSessionSheet(
        session: widget.session,
      ),
    );

    if (canceled ?? false) {
      context.pop();
    }
  }

  void _startMessaging() {
    launchMessage();
  }

  void launchMessage() async {

  }

  void _endSession(BuildContext context) async {
    final bool? sessionEnded = await CustomDialogs.showBottomSheet(
        context,
        EndTherapySessionDialog(
          session: widget.session,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        constraints: BoxConstraints(maxHeight: 0.9.sh));

    if (sessionEnded ?? false) {
      final bool? writeReview = await CustomDialogs.showCustomDialog(
          TherapySessionEndedDialog(sessionDetails: widget.session), context);

      logger.i(writeReview);

      if (writeReview ?? false) {
        final bool? wroteFeedback = await CustomDialogs.showBottomSheet(
            context,
            TherapyReviewSheet(
              session: widget.session,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            constraints: BoxConstraints(maxHeight: 0.9.sh));

        if (wroteFeedback ?? false) {
          await CustomDialogs.showBottomSheet(
              context,
              SuccessDialog(
                tittle: feedbackSuccessMessage,
                onClose: () {
                  context.pop();
                },
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
              constraints: BoxConstraints(maxHeight: 0.9.sh));
          // context.pop();
        }
        context.pop();
      } else {
        context.pop();
      }
    }
  }
}
