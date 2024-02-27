import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState(
      {super.key, this.tittle, this.subtittle, this.hasBg = true});

  final String? tittle;
  final String? subtittle;
  final bool? hasBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: 1.sw,
      decoration: ShapeDecoration(
          color: hasBg! ? Pallets.white : Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            imageUrl: Assets.images.pngs.emptyBascket.path,
            size: 120,
          ),
          15.verticalSpace,
          TextView(
            text: tittle ?? "Your Favorites Space Awaits",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Pallets.primary,
          ),
          5.verticalSpace,
          TextView(
            text:
                subtittle ?? "Looks like you haven't added any favorites yet.",
            fontSize: 14,
            align: TextAlign.center,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}
