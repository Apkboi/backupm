import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'dotted_border.dart';

class EmptyPhotoCard extends StatefulWidget {
  const EmptyPhotoCard({
    super.key,
  });

  @override
  State<EmptyPhotoCard> createState() => _EmptyPhotoCardState();
}

class _EmptyPhotoCardState extends State<EmptyPhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          height: 250,
          width: 1.sw,
          // margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DashedRect(
            color: Pallets.grey90,
            strokeWidth: 1.0,
            gap: 8.0,
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(imageUrl: "Assets.images.svgs.cloudUpload"),
              8.verticalSpace,
              TextView(
                text: 'Upload Document',
                style: GoogleFonts.sora(
                  color: Pallets.grey35,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextView(
                  text: 'Supported format: .doc, .docx, PDF',
                  // text: 'Supported format: jpeg, png ,jpg less than 5MB',
                  style: GoogleFonts.sora(
                    color: Pallets.grey35,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
