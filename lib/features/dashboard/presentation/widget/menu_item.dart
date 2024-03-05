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
      required this.text,
      this.onTap});

  final Color textColor;
  final Color? bgColor;
  final String image;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:( 0.53/2).sh,
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
              16.verticalSpace,
              Expanded(
                child: ImageWidget(
                  imageUrl: image,

                  onTap: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  canPreview: false,
                  fit: BoxFit.scaleDown,
                  height: 120.h,
                  width: 1.sw,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: const Center(
            child: SizedBox(
              height: 150,
              width: 150,
            ),
          ),
        ),
      ],
    );
  }
}
