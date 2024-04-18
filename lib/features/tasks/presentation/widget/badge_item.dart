import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/streaks/data/model/get_streaks_response.dart';

class BadgeItem extends StatelessWidget {
  const BadgeItem({super.key, required this.streak, required this.fadeOut});

  final BadgeModel streak;
  final bool fadeOut;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: fadeOut ? 0.5 : 1,
      duration: const Duration(milliseconds: 000),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageWidget(
                  imageUrl: streak.image.url,
                  size: 70,
                ),
                12.verticalSpace,
                TextView(
                  text: streak.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
            if (streak.isCurrentBadge)
              const Positioned(
                top: -5,
                right: -5,
                child: Icon(
                  Icons.check_circle,
                  color: Pallets.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
