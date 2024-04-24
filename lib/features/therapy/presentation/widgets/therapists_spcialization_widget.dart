import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/bullet_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';

class TherapistSpecializationWidget extends StatelessWidget {
  const TherapistSpecializationWidget(
      {super.key, required this.suggestedTherapist});

  final SuggestedTherapist suggestedTherapist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Pallets.white),
      child: Column(
        children: [
          if (suggestedTherapist.therapist.techniquesOfExpertise.isEmpty)
            const SizedBox(
              height: 100,
              child: Center(child: TextView(text: 'No Specializations')),
            ),
          ...List.generate(
              suggestedTherapist.therapist.techniquesOfExpertise.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: BulletWidget(
                        text: suggestedTherapist
                            .therapist.techniquesOfExpertise[index]),
                  ))
        ],
      ),
    );
  }
}
