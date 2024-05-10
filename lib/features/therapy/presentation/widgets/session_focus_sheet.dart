import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class SessionFocusSheet extends StatefulWidget {
  SessionFocusSheet({super.key});

  @override
  State<SessionFocusSheet> createState() => _SessionFocusSheetState();
}

class _SessionFocusSheetState extends State<SessionFocusSheet> {
  @override
  void initState() {
    injector.get<TherapyBloc>().add(const GetSessionFocusEvent());
    super.initState();
  }

  //
  // List sessionFocuses = [
  //   'Developing coping strategies for anxiety',
  //   'Resolving interpersonal conflicts',
  //   'Building self esteem and confidence',
  //   'Managing depression and mood fluctuations'
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Pallets.bottomSheetColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          16.verticalSpace,
          TextView(
            text: 'Select Session Focus',
            style: GoogleFonts.fraunces(
                fontSize: 20.sp,
                color: Pallets.navy,
                fontWeight: FontWeight.w600),
          ),
          16.verticalSpace,
          SizedBox(
            height: 400,
            child: BlocConsumer<TherapyBloc, TherapyState>(
              listener: _listenToTherapySessionBloc,
              bloc: injector.get(),
              builder: (context, state) {
                if (state is GetSessionFocusLoadingState) {
                  return Center(
                    child: CustomDialogs.getLoading(size: 30),
                  );
                }

                if (state is GetSessionFocusFailureState) {
                  return AppPromptWidget(
                    title: 'Ooops!',
                    message: state.error,
                    onTap: () {
                      injector
                          .get<TherapyBloc>()
                          .add(const GetSessionFocusEvent());
                    },
                  );
                }

                if (state is GetSessionFocusSuccessState) {
                  return ListView.builder(
                    itemCount: state.response.data.length,
                    itemBuilder: (context, index) => Material(
                      color: Colors.transparent,
                      child: HapticInkWell(
                        onTap: () {
                          context.pop(state.response.data[index].name);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.verticalSpace,
                            TextView(
                              text: state.response.data[index].name,
                              fontSize: 16,
                            ),
                            10.verticalSpace,
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return 0.verticalSpace;
              },
            ),
          )
        ],
      ),
    );
  }

  void _listenToTherapySessionBloc(BuildContext context, TherapyState state) {}
}
