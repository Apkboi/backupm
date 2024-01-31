import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/bullet_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

class TherapistAboutWidget extends StatelessWidget {
  const TherapistAboutWidget({super.key, required this.therapist});

  final SuggestedTherapist therapist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Pallets.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(text: therapist.therapist.bio ?? therapist.therapist.field),
          10.verticalSpace,
          if (therapist.therapist.degrees != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextView(
                  text: "Degree:",
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: BulletWidget(text: therapist.therapist.degrees),
                ),
                16.verticalSpace,
              ],
            ),

          if(therapist.therapist.certifications!= null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const TextView(
                text: "Certifications:",
                fontWeight: FontWeight.w500,
              ),
              ...List.generate(
                  therapist.therapist.certifications.length,
                      (index) =>  Padding(
                    padding:const EdgeInsets.symmetric(vertical: 8),
                    child: BulletWidget(
                        text: therapist.therapist.certifications[index]),
                  )),
              16.verticalSpace,
            ],),

          const TextView(
            text: "Experience::",
            fontWeight: FontWeight.w500,
          ),
          5.verticalSpace,
           TextView(
            text: "Over ${therapist.therapist.yearsOfExperience} years in private practice and clinical research",
          ),
        ],
      ),
    );
  }
}
