import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/extensions/context_extension.dart';
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

  @override
  Widget build(BuildContext context) {
    return Material(
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
                text: widget.tittle ?? 'Select date',
                style: GoogleFonts.fraunces(
                    color: Pallets.navy,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600),
              ),
              10.verticalSpace,
              Expanded(
                child: Theme(
                  data: context.theme.copyWith(
                      colorScheme: context.colorScheme.copyWith(
                          primary: Pallets.lightSecondary,
                          onPrimary: Pallets.black),
                      primaryColor: Pallets.secondary),
                  child: CalendarDatePicker(

                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                    onDateChanged: (value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                  ),
                ),
              ),
              CustomNeumorphicButton(
                  text: 'Continue',
                  onTap: () {
                    widget.onSelected(selectedDate);
                  },
                  color: Pallets.primary),
              20.verticalSpace
            ],
          ),
        ),
      ),
    );
  }
}
