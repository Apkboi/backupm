import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class UpcomingSession extends StatelessWidget {
  const UpcomingSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
          color: Pallets.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 25),
      child: Column(
        children: [
          const ImageWidget(
            imageUrl: '',
            size: 50,
            color: Pallets.primary,
          ),
          16.verticalSpace,
          const TextView(
            text: "Looks like you haven't scheduled your\n next session.",
            align: TextAlign.center,
            fontSize: 13,
          )
        ],
      ),
    );
  }
}
