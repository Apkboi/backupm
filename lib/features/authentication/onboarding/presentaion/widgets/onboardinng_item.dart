import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/widgets/indicator.dart';

class OnboardingItem extends StatefulWidget {
  const OnboardingItem(
      {Key? key, required this.text, required this.header, required this.img, required this.index})
      : super(key: key);
  final String text;
  final String header;
  final String img;
  final int index;

  @override
  _OnboardingItemState createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // image:
          //     DecorationImage(image: AssetImage(widget.img), fit: BoxFit.cover),
          ),
      child: Container(
        decoration: const BoxDecoration(),
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        // height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            108.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(children: [
                TextView(
                    text: widget.header,
                    align: TextAlign.center,
                    style: GoogleFonts.fraunces(
                      color: Pallets.navy,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    )),
                10.h.verticalSpace,
                TextView(
                    text: widget.text,
                    align: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Pallets.black80,
                        fontWeight: FontWeight.w500)),
              ],),
            ),
            20.verticalSpace,

             Indicator(
              seledtedIndex: widget.index,
              items_count: 2,
            ),
            40.verticalSpace,

            Expanded(
              child: ImageWidget(
                        // shape: BoxShape.rectangle,
                        // height: 260.h,
                        width: 1.sw,
                        fit: BoxFit.scaleDown,
                        // borderRadius: BorderRadius.circular(10),
                        imageUrl: widget.img,
                      ),
            ),
            // 35.verticalSpace,

            // SizedBox(
            //   height: 8,
            // ),
          ],
        ),
      ),
    );
  }
}
