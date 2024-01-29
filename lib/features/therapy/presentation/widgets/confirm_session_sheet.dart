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
import 'package:mentra/core/theme/app_styles.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/time_util.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/session_scheduled_dialog.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/data/models/create_session_response.dart';
import 'package:mentra/features/therapy/presentation/widgets/session_focus_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConfirmSessionSheet extends StatefulWidget {
  const ConfirmSessionSheet({super.key});

  @override
  State<ConfirmSessionSheet> createState() => _ConfirmSessionSheetState();
}

class _ConfirmSessionSheetState extends State<ConfirmSessionSheet> {
  String? focus;

  final _notesController = TextEditingController();
  final therapyBloc = TherapyBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Pallets.bottomSheetColor,
      child: BlocConsumer<TherapyBloc, TherapyState>(
        bloc: injector.get(),
        listener: _listenToTherapyBloc,
        builder: (context, state) {
          return CupertinoScaffold(
              transitionBackgroundColor: Pallets.bottomSheetColor,
              body: Padding(
                padding: const EdgeInsets.all(16),
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
                    TextView(
                      text: 'Confirm your session',
                      style: GoogleFonts.fraunces(
                          color: Pallets.navy,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Pallets.white,
                          borderRadius: BorderRadius.circular(17)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ImageWidget(
                                        imageUrl:
                                            Assets.images.svgs.icCalender),
                                    10.horizontalSpace,
                                    TextView(
                                      text: TimeUtil.formatFromDate(injector
                                          .get<TherapyBloc>()
                                          .createSessionsPayload
                                          .date),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  children: [
                                    ImageWidget(
                                        imageUrl: Assets.images.svgs.icClock),
                                    10.horizontalSpace,
                                    TextView(
                                      text: injector
                                          .get<TherapyBloc>()
                                          .createSessionsPayload
                                          .time,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text(
                                'Change',
                                style: TextStyle(
                                    color: Pallets.primary,
                                    fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    InkWell(
                      onTap: () {
                        _selectSessionFocus();
                      },
                      child: Container(
                        decoration:
                            AppStyles.customFilledTextFieldBoxDecoration,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextView(
                                    text: 'Session Focus',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  TextView(
                                      text: focus ?? 'Select session focus'),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Pallets.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration:
                          AppStyles.customBorderedTextFieldBoxDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextView(
                                text: 'Note',
                                style: GoogleFonts.inter(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              TextView(
                                text: ' (Optional)',
                                style: GoogleFonts.inter(
                                    fontSize: 12, color: Pallets.grey),
                              ),
                            ],
                          ),
                          7.verticalSpace,
                          FilledTextField(
                              maxLine: 5,
                              hasElevation: false,
                              contentPadding: EdgeInsets.zero,
                              hasBorder: false,
                              controller: _notesController,
                              fillColor: Colors.transparent,
                              hint: 'Not Selected'),
                        ],
                      ),
                    ),
                    Expanded(child: 16.verticalSpace),
                    focus != null
                        ? CustomNeumorphicButton(
                            text: 'Continue',
                            onTap: () {
                              _scheduleSession(context);
                              // _closeAllSheets(context);
                            },
                            color: Pallets.primary)
                        : 0.horizontalSpace
                  ],
                ),
              ));
        },
      ),
    );
  }

  void sessionCreated(BuildContext context,
      {required CreateSessionResponse sessionDetails}) {
    injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());

    context.pop();
    context.pop();
    context.pop();
    context.pop();
    // CustomDialogs.hideLoading(context);
    CustomDialogs.showCustomDialog(
        SessionScheduledDialog(sessionDetails: sessionDetails.data), context);
  }

  void sessionRescheduled(BuildContext context,
      {required CreateSessionResponse sessionDetails}) {
    injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());

    // rootNavigatorKey.currentState?.pop();
    context.pop();
    context.pop();
    context.pop();
    context.pop();
    context.pop();

    // CustomDialogs.hideLoading(context);!
    CustomDialogs.showCustomDialog(
        SessionScheduledDialog(
          sessionDetails: sessionDetails.data,
          tittle: "Session Rescheduled successfully",
        ),
        context);
  }

  void _selectSessionFocus() async {
    focus = await CustomDialogs.showBottomSheet(context, SessionFocusSheet());

    setState(() {});
  }

  void _scheduleSession(BuildContext context) {
    injector
        .get<TherapyBloc>()
        .updatePayload(note: _notesController.text, focus: focus);
    injector.get<TherapyBloc>().scheduleOrRescheduleSession();
  }

  void _listenToTherapyBloc(BuildContext _context, TherapyState state) {
    if (state is RescheduleSessionFailureState) {
      _context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is CreateSessionFailureState) {
      _context.pop();
      CustomDialogs.error(state.error);
    }

    if (state is CreateSessionLoadingState ||
        state is RescheduleSessionLoadingState) {
      CustomDialogs.showLoading(_context);
    }
    if (state is CreateSessionSuccessState) {
      sessionCreated(_context, sessionDetails: state.response);
    }
    if (state is RescheduleSessionSuccessState) {
      sessionRescheduled(_context, sessionDetails: state.response);
    }
  }
}
