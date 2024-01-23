import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class LibraryItem extends StatelessWidget {
  const LibraryItem(
      {Key? key,
      required this.bgColor,
      required this.text,
      required this.image,
      this.onTap})
      : super(key: key);
  final Color bgColor;
  final String text;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17), color: bgColor),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: text,
                      style: GoogleFonts.fraunces(
                          color: Pallets.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Pallets.white,
                            padding: EdgeInsets.zero),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextView(
                              text: 'Explore',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            8.horizontalSpace,
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                            )
                          ],
                        ))
                  ],
                ),
              ),
              ImageWidget(
                imageUrl: image,
                width: 120.w,
                height: 120.h,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
