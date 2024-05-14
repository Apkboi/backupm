import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';

class SessionFocusSheet extends StatefulWidget {
  const SessionFocusSheet({super.key, required this.selectedSessionFocus});

  final List<String> selectedSessionFocus;

  @override
  State<SessionFocusSheet> createState() => _SessionFocusSheetState();
}

class _SessionFocusSheetState extends State<SessionFocusSheet> {
  List<String> selectedFocuses = [];

  @override
  void initState() {
    injector.get<TherapyBloc>().add(const GetSessionFocusEvent());
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        setState(() {
          selectedFocuses = widget.selectedSessionFocus;
        });
      },
    );
    super.initState();
  }

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
        // mainAxisSize: MainAxisSize.min,
        children: [
          50.verticalSpace,
          TextView(
            text: 'Select Session Focus (Multiple allowed)',
            style: GoogleFonts.fraunces(
                fontSize: 20.sp,
                color: Pallets.navy,
                fontWeight: FontWeight.w600),
          ),
          16.verticalSpace,
          Expanded(
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
                    itemBuilder: (context, index) => Column(
                      children: [
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: Pallets.primary,
                          title: Text(state.response.data[index].name),
                          value: selectedFocuses
                              .contains(state.response.data[index].name),
                          onChanged: (newValue) => setState(() {
                            if (newValue!) {
                              selectedFocuses.add(state.response.data[index].name);
                            } else {
                              selectedFocuses
                                  .remove(state.response.data[index].name);
                            }
                          }),
                        ),
                        8.verticalSpace,
                        const Divider(height: 5,thickness: 1.3,)
                      ],
                    ),
                  );
                }

                return 0.verticalSpace;
              },
            ),
          ),
          // const Spacer(),
          Center(
            child: CustomNeumorphicButton(
              fgColor: Pallets.white,
              onTap: () => context.pop(selectedFocuses),
              color: Pallets.primary,
              child: const Text('Continue',style: TextStyle(color: Pallets.white),),
            ),
          ),
        ],
      ),
    );
  }

  void _listenToTherapySessionBloc(BuildContext context, TherapyState state) {}
}
