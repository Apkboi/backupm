import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/bullet_widget.dart';
import 'package:mentra/core/theme/pallets.dart';

class TherapistSpecializationWidget extends StatelessWidget {
  const TherapistSpecializationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Pallets.white),
      child: Column(
        children: [
          ...List.generate(
              3, (index) =>
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: BulletWidget(
                    text: "Anxiety and Stress Management"),
              ))
        ],
      ),
    );
  }
}
