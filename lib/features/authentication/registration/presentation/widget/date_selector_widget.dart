import 'package:flutter/material.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({super.key});

  @override
  _SelectableYearsListState createState() => _SelectableYearsListState();
}

class _SelectableYearsListState extends State<DateSelectorWidget> {
  int selectedYear =
      DateTime.now().year; // Initial selection is the current year

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2024 - 1899 + 1,
      itemBuilder: (context, index) {
        int year = 1899 + index;
        bool isSelected = year == selectedYear;

        return InkWell(
          onTap: () {
            setState(() {
              selectedYear = year;
            });
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  // shape: BoxShape.circle,
                  color:
                      isSelected ? Pallets.lightSecondary : Pallets.lightTurquoise,
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
