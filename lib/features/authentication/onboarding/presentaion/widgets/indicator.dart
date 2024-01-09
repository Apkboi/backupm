import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/core/theme/pallets.dart';

class Indicator extends StatefulWidget {
  const Indicator(
      {Key? key, required this.seledtedIndex, required this.items_count})
      : super(key: key);
  final int seledtedIndex;
  final int items_count;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.items_count,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric( horizontal: 5),
          child: AnimatedContainer(
              // margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              width: 10.w,
              duration: const Duration(milliseconds: 700),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (widget.seledtedIndex == index)
                      ? Pallets.navy
                      : Pallets.turquoise1)),
        ),
      ),
    );
  }
}
