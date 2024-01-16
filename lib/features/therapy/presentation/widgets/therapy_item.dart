import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_details_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapyItem extends StatelessWidget {
  const TherapyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomDialogs.showCupertinoBottomSheet(context, const TherapyDetailsSheet());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const TherapyStatusIndicator(),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: 'Managing Anxiety',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    8.verticalSpace,
                    const TextView(
                      text: 'Session with Nour Martin, Ph.D.',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    const TextView(
                      text: 'Today, at 4:00 PM',
                      color: Pallets.ink,
                    ),
                    8.verticalSpace,
                    CustomNeumorphicButton(
                        expanded: false,
                        text: 'Join session',
                        padding: const EdgeInsets.all(10),
                        onTap: () {},
                        color: Pallets.primary)
                  ],
                ),
              ),
              ImageWidget(
                imageUrl: Assets.images.svgs.avatar1,
                size: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TherapyStatusIndicator extends StatelessWidget {
  const TherapyStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(37),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Active
              colors: [Color(0xffd4f7e9), Color(0xffeffaf6)],
              // History
              // colors: [Color(0xffe0e3e7), Color(0xffe0e3e7)],
              // Awaiting
              // colors: [Color(0xffffdac1), Color(0xfffef3eb)],
            )));
  }
}
