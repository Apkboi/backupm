import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/theme/pallets.dart';

class ReviewSheet extends StatefulWidget {
  const ReviewSheet({Key? key}) : super(key: key);

  @override
  State<ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<ReviewSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallets.white,
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 49,
            height: 5,
            decoration: ShapeDecoration(
              color: const Color(0xFFBCC4CC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
            ),
          ),
          10.verticalSpace,
          TextView(
            text: reviewTittle,
            align: TextAlign.center,
            style: GoogleFonts.fraunces(
                fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          22.verticalSpace,
          const TextView(
            text: reviewSubtext,
            align: TextAlign.center,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Pallets.ink,
          ),
          20.verticalSpace,
          const TextView(
            text: 'Star Rating',
            align: TextAlign.center,
            fontWeight: FontWeight.w400,
            color: Pallets.ink,
          ),
          10.verticalSpace,
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            glow: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(
                          color: Colors.grey.withOpacity(
                            0.5,
                          ),
                          width: 0.5))),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.star_rounded,
                  color: Pallets.yellowBase,
                  // size: 18,
                ),
              ),
            ),
            onRatingUpdate: (rating) {
              // if (kDebugMode) {
              //   print(rating);
              // }
            },
          ),
          22.verticalSpace,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                        color: Colors.grey.withOpacity(
                          0.3,
                        ),
                        width: 0.8))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'Review',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                7.verticalSpace,
                const FilledTextField(
                    maxLine: 5,
                    hasElevation: false,
                    contentPadding: EdgeInsets.zero,
                    hasBorder: false,
                    fillColor: Colors.transparent,
                    hint:
                        'Share your thoughts! How did Mentra support you today? Your words make a difference.'),
              ],
            ),
          ),
          43.verticalSpace,
          CustomNeumorphicButton(
            onTap: () {
              context.pop(true);
              // context.pop();
              // CustomDialogs.showBottomSheet(
              //     context, const EndSessionDialog(),
              //     shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(16),
              //           topRight: Radius.circular(16),
              //         )),
              //     constraints: BoxConstraints(maxHeight: 0.9.sh));
            },
            color: Pallets.primary,
            text: "Submit Review",
          ),
          17.verticalSpace,
        ],
      ),
    );
  }
}
