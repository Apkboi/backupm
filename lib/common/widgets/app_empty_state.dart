import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'custom_button.dart';
import 'image_widget.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget(
      {super.key,
      required this.onRefresh,
      required this.onButtonClick,
      required this.buttonText,
      required this.tittle,
      required this.subtitle,
      this.image});

  final VoidCallback onRefresh;
  final VoidCallback onButtonClick;
  final String buttonText;
  final String tittle;
  final String subtitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {
          onRefresh();
        },
        child: ListView(

          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageWidget(
                    imageUrl: image ??" Assets.images.svgs.noRequest",
                    height: 0.6.sh,
                  ),
                  40.verticalSpace,
                  TextView(
                    text: tittle,
                    style: GoogleFonts.sora(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  12.verticalSpace,
                  TextView(
                    align: TextAlign.center,
                    text: subtitle,
                    fontSize: 14,
                    color: Pallets.grey35,
                    fontWeight: FontWeight.w400,
                  ),
                  30.verticalSpace,
                  CustomButton(
                      isExpanded: false,
                      borderRadius: BorderRadius.circular(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      onPressed: () {
                        onButtonClick();
                      },
                      child: TextView(
                        text: buttonText,
                        style: GoogleFonts.sora(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
