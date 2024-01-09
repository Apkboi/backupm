
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';


class TextWithUndeline extends StatelessWidget {
  const TextWithUndeline({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        5.verticalSpace,
        Container(
          width: 89.w,
          height: 2,
          color: Pallets.primary,
        )
      ],
    );
  }
}
