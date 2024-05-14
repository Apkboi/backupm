import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/extensions/context_extension.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SelectDateSheet extends StatefulWidget {
  const SelectDateSheet({super.key, this.tittle, required this.onSelected});

  final String? tittle;

  final Function(DateTime onSelected) onSelected;

  @override
  State<SelectDateSheet> createState() => _SelectDateSheetState();
}

class _SelectDateSheetState extends State<SelectDateSheet> {
  DateTime selectedDate = DateTime.now();
  final _bloc = TherapyBloc(injector.get());

  @override
  void initState() {
    _bloc.add(GetAvailableDatesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<TherapyBloc, TherapyState>(
        bloc: _bloc,
        listener: (context, state) {},
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
                    text: widget.tittle ?? 'Select Date',
                    style: GoogleFonts.fraunces(
                        color: Pallets.navy,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  10.verticalSpace,
                  Builder(builder: (context) {
                    if (state is GetAvailableDatesSuccessState) {
                      if (state.response.data.isNotEmpty) {
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Theme(
                                  data: context.theme.copyWith(
                                      textTheme: context.textTheme.copyWith(
                                        titleLarge: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      colorScheme: context.colorScheme.copyWith(
                                          primary: Pallets.lightSecondary,
                                          onPrimary: Pallets.black),
                                      primaryColor: Pallets.secondary),
                                  child: CalendarDatePicker(
                                    initialDate: state.response.data.first,
                                    currentDate: state.response.data.first,

                                    selectableDayPredicate: (DateTime date) {
                                      // Check if the date is in the list of available date slots
                                      return (state)
                                          .response
                                          .data
                                          .contains(date);
                                    },
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 30)),
                                    // Set a past date as the first selectable date
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 30)),
                                    // Set a future date as the last selectable date
                                    onDateChanged: (value) {
                                      setState(() {
                                        selectedDate = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Center(
                                child: CustomNeumorphicButton(
                                    text: 'Continue',
                                    onTap: () {
                                      widget.onSelected(selectedDate);
                                    },
                                    color: Pallets.primary),
                              ),
                              20.verticalSpace
                            ],
                          ),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: AppEmptyState(
                              tittle: "No available time slot",
                              hasBg: false,
                              subtittle:
                                  'Looks like their are no time slots available for your therapist',
                            ),
                          ),
                        );
                      }
                    }
                    if (state is GetAvailableDatesLoadingState) {
                      return Expanded(
                          child: Center(
                        child: CustomDialogs.getLoading(
                            size: 50, color: Pallets.primary),
                      ));
                    }
                    if (state is GetAvailableDatesFailureState) {
                      return AppPromptWidget(
                        textColor: Pallets.primary,
                        message: state.error,
                        retryTextColor: Pallets.primary,
                        onTap: () {
                          _bloc.add(GetAvailableDatesEvent());
                        },
                      );
                    }

                    return 0.verticalSpace;
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// String _formatDate(DateTime date) {
//   // Format the date as 'yyyy-MM-dd' to match the available date slots
//   return DateFormat('yyyy-MM-dd').format(date);
// }
//
// int getHighestYear(List<DateTime> dateTimes) {
//   if (dateTimes.isEmpty) {
//     throw ArgumentError('The list of DateTime objects is empty.');
//   }
//
//   int highestYear = dateTimes.map((dateTime) => dateTime.year).reduce((max, current) => max > current ? max : current);
//
//   return highestYear;
// }
}
