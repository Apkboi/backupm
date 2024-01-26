import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/extensions/date_extensions.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'confirm_session_sheet.dart';

class SelectTimeSheet extends StatefulWidget {
  const SelectTimeSheet({super.key, required this.date});

  final DateTime date;

  @override
  State<SelectTimeSheet> createState() => _SelectTimeSheetState();
}

class _SelectTimeSheetState extends State<SelectTimeSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Pallets.bottomSheetColor,
      child: CupertinoScaffold(
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
                  text: 'Select time',
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
                      const TextView(
                        text: 'Date:',
                        color: Pallets.ink,
                        fontWeight: FontWeight.w600,
                      ),
                      Expanded(
                        child: TextView(
                          text: TimeUtil.formatFromDate(injector
                              .get<TherapyBloc>()
                              .createSessionsPayload
                              .date),
                          fontWeight: FontWeight.w600,
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
                 SelectableTimeSlots(widget.date.toCustomString),
                const Spacer(),
                20.verticalSpace,
                CustomNeumorphicButton(
                    text: 'Continue',
                    onTap: () {
                      CustomDialogs.showCupertinoBottomSheet(
                          context, const ConfirmSessionSheet());
                    },
                    color: Pallets.primary)
              ],
            ),
          )),
    );
  }
}

class SelectableTimeSlots extends StatefulWidget {
  final String date;

  const SelectableTimeSlots(this.date, {super.key});

  @override
  _SelectableTimeSlotsState createState() => _SelectableTimeSlotsState();
}

class _SelectableTimeSlotsState extends State<SelectableTimeSlots> {
  int selectedSlot = -1; // Initially, no slot is selected

  List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '3:00 PM',
    '3:00 PM',
    // Add more time slots as needed
  ];

  final therapyBloc = TherapyBloc(injector.get());

  @override
  void initState() {
    therapyBloc.add(GetTimeSlotsEvent(date: widget.date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Pallets.white, borderRadius: BorderRadius.circular(17)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextView(
            text: 'Available time slots',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          16.verticalSpace,
          BlocConsumer<TherapyBloc, TherapyState>(
            bloc: therapyBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetTimeSlotsoadingState) {
                return SizedBox(
                  height: 150.h,
                  child: Center(
                    child: CustomDialogs.getLoading(size: 40),
                  ),
                );
              }

              if (state is GetTimeSlotsSuccessState) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 3),
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedSlot;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSlot = isSelected ? -1 : index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Pallets.lightSecondary
                              : Pallets.white,
                          border: Border.all(
                            color: Colors.black,
                            width: isSelected ? 0 : 0.9,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            timeSlots[index],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              if (state is GetTimeSlotsFailureState) {
                return SizedBox(
                  height: 150.h,
                  child: Center(
                    child: CustomDialogs.getLoading(size: 40),
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
