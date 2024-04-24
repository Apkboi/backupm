import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapistsReviewWidget extends StatelessWidget {
  const TherapistsReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: Pallets.white),
      child: const Column(
        children: [
          SizedBox(
              height: 100,
              child: Center(child: TextView(text: 'No Reviews')))

          // ...List.generate(
          //     3,
          //     (index) => const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 16),
          //           child: ReviewItem(),
          //         ))
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageWidget(
              imageUrl: Assets.images.pngs.avatar4.path,
              size: 32,
            ),
            8.horizontalSpace,
            const Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'Wanda',
                  fontWeight: FontWeight.w600,
                ),
                TextView(
                    text: 'Wanda',
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Pallets.ink),
              ],
            )),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              glow: false,
              itemCount: 5,
              itemSize: 16,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: Pallets.yellowBase,
                size: 6,
              ),
              onRatingUpdate: (rating) {
                // if (kDebugMode) {
                //   print(rating);
                // }
              },
            ),
          ],
        ),
        16.verticalSpace,
        TextView(
          text: lorem,
          style: GoogleFonts.plusJakartaSans(),
        ),
      ],
    );
  }
}
