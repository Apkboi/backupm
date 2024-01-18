import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/bullet_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/theme/pallets.dart';

class TherapistAboutWidget extends StatelessWidget {
  const TherapistAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: Pallets.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextView(text: lorem),
          10.verticalSpace,
          const TextView(
            text: "Degree:",
            fontWeight: FontWeight.w500,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: BulletWidget(text: 'Ph.D. in Clinical Psychology'),
          ),
          16.verticalSpace,
          const TextView(
            text: "Certifications:",
            fontWeight: FontWeight.w500,
          ),
          ...List.generate(
              3,
              (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: BulletWidget(
                        text: 'Certified Cognitive-Behavioral Therapist (CBT)'),
                  )),
          16.verticalSpace,
          const TextView(
            text: "Experience::",
            fontWeight: FontWeight.w500,
          ),
          5.verticalSpace,
          const TextView(
            text: "Over 15 years in private practice and clinical research",

          ),
        ],
      ),
    );
  }
}
