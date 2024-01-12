import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.textColor,
      required this.bgColor,
      required this.image,
      required this.text});

  final Color textColor;
  final Color? bgColor;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: bgColor ?? Pallets.white),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: text,
            style: GoogleFonts.fraunces(
              fontSize: 20.sp,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          2.verticalSpace,
          ImageWidget(
            imageUrl: image,
            height: 120,
          )
        ],
      ),
    );
  }
}
