import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapyEmptyState extends StatelessWidget {
  const TherapyEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: 1.sw,
      decoration: ShapeDecoration(
          color: Pallets.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Column(
        children: [
          ImageWidget(imageUrl: Assets.images.svgs.success),
          15.verticalSpace,
          const TextView(
            text: "Your Favorites Space Awaits",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Pallets.primary,
          ),
          5.verticalSpace,
          const TextView(
            text: "Looks like you haven't added any favorites yet.",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
