import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

class BulletWidget extends StatelessWidget {
  const BulletWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Icon(
            Icons.circle,
            size: 8,
            color: Pallets.black,
          ),
        ),
        8.horizontalSpace,
        Expanded(
            child: TextView(
          text: text,
        ))
      ],
    );
  }
}
