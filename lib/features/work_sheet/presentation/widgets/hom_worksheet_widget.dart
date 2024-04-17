import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class HomeWorkSheetWidget extends StatefulWidget {
  const HomeWorkSheetWidget({super.key});

  @override
  State<HomeWorkSheetWidget> createState() => _HomeWorkSheetWidgetState();
}

class _HomeWorkSheetWidgetState extends State<HomeWorkSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
          color: Pallets.moodCheckerBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Pallets.navy,
                    borderRadius: BorderRadius.circular(100)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                child: const TextView(
                  text: 'Pending',
                  color: Pallets.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.verticalSpace,
              const TextView(
                text: 'Challenging unhelpful thoughts',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              5.verticalSpace,
              const TextView(
                text: 'Sunday, 12 June',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ],
          )),
          CustomNeumorphicButton(
              padding: const EdgeInsets.all(6),
              expanded: false,
              fgColor: Pallets.black,
              onTap: () {},
              text: 'Try this',
              color: Pallets.secondary)
        ],
      ),
    );
  }
}
