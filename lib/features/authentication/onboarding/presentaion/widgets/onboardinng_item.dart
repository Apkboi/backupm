import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

class OnboardingItem extends StatefulWidget {
  const OnboardingItem(
      {Key? key, required this.text, required this.header, required this.img})
      : super(key: key);
  final String text;
  final String header;
  final String img;

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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        // height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Center(
                    child: ImageWidget(
              shape: BoxShape.rectangle,
              height: 1.sh,
              width: 1.sw,
              borderRadius: BorderRadius.circular(10),
              imageUrl: widget.img,
            ))),
            35.verticalSpace,
            TextView(
                text: widget.header,
                align: TextAlign.center,
                style: GoogleFonts.fraunces(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(
              height: 16,
            ),
            TextView(
                text: widget.text,
                align: TextAlign.center,
                style:  TextStyle(
                    fontSize: 14.sp,
                    color: Pallets.grey,
                    fontWeight: FontWeight.w500)),
            // SizedBox(
            //   height: 8,
            // ),
          ],
        ),
      ),
    );
  }
}
