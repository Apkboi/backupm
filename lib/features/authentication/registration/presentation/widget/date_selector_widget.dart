import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';


class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({
    super.key,
    required this.onYearSelected,
    this.alignment,
    this.selectedColor,
    this.selectedTextColor,
    this.buttonColo4,
    this.initialYear,
  });

  final Function(int year) onYearSelected;
  final Alignment? alignment;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? buttonColo4;
  final int? initialYear;

  @override
  _SelectableYearsListState createState() => _SelectableYearsListState();
}

class _SelectableYearsListState extends State<DateSelectorWidget> {
  final ItemScrollController? scrollController = ItemScrollController();
  int selectedYear = DateTime.now().year; // Initial sel
  List<int> years = List<int>.generate(
      2025 - 1899, (index) => 1899 + index); // ection is the current year

  @override
  void initState() {
    if (widget.initialYear != null) {
      selectedYear = widget.initialYear!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        if (mounted) {
          scrollController?.jumpTo(
            index: years.indexWhere((element) => element == selectedYear),
          );
        }
      },
    );
    return ScrollablePositionedList.builder(
      itemScrollController: scrollController,
      itemCount: years.length,
      itemBuilder: (context, index) {
        int year = 1899 + index;
        bool isSelected = year == selectedYear;

        return Align(
          alignment: widget.alignment ?? Alignment.centerRight,
          child: HapticInkWell(
            onTap: () {
              setState(() {
                selectedYear = year;
              });
              widget.onYearSelected(selectedYear);
            },
            child: Padding(
              padding:  EdgeInsets.only(top: 8.0.h),
              child: Container(
                width: 80.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1),
                  // shape: BoxShape.circle,
                  color: isSelected
                      ? widget.selectedColor ?? Pallets.lightSecondary
                      : Pallets.lightTurquoise,
                ),
                child: Center(
                  child: Text(
                    '$year',
                    style: TextStyle(color: Pallets.black, fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
