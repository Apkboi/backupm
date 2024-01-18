import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class PlanDetailsItem extends StatefulWidget {
  const PlanDetailsItem({Key? key}) : super(key: key);

  @override
  State<PlanDetailsItem> createState() => _PlanDetailsItemState();
}

class _PlanDetailsItemState extends State<PlanDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  // color: Pallets.grey,
                  decoration: ShapeDecoration(
                      // color: Pallets.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextView(
                              text: 'Essential',
                              style: GoogleFonts.fraunces(
                                  color: Pallets.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            5.verticalSpace,
                            const TextView(
                                text: '79 AED/month',
                                fontSize: 18,
                                color: Pallets.lightSecondary,
                                fontWeight: FontWeight.w500),
                            10.verticalSpace,
                            const TextView(
                                text:
                                    'Upgrade to our Essential Plan for enhanced features and a more robust experience.',
                                color: Pallets.navy,
                                fontWeight: FontWeight.w500),
                            10.verticalSpace,
                            ...List.generate(2, (index) => const PlanFeature()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            CustomOutlinedButton(
              radius: 100,
              bgColor: Pallets.white,
              outlinedColr: Pallets.primary,
              padding: const EdgeInsets.all(16),
              child: const Text('Subscribe Monthly\n(AED 79/month)'),
              onPressed: () {},
            ),
            10.verticalSpace,
            CustomNeumorphicButton(onTap: () {}, color: Pallets.primary),
            21.verticalSpace
          ],
        )
      ],
    );
  }
}

class PlanFeature extends StatelessWidget {
  const PlanFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Pallets.lightSecondary,
            size: 24,
          ),
          8.horizontalSpace,
          const TextView(text: 'Daily limited access to Talk to Mentra')
        ],
      ),
    );
  }
}
