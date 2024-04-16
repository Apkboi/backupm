import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NotificationDetailsSheet extends StatefulWidget {
  const NotificationDetailsSheet({
    super.key,
  });

  @override
  State<NotificationDetailsSheet> createState() =>
      _NotificationDetailsSheetState();
}

class _NotificationDetailsSheetState extends State<NotificationDetailsSheet> {

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      transitionBackgroundColor: Pallets.bottomSheetColor,
      // backgroundColor: Pallets.bottomSheetColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Pallets.black,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            20.verticalSpace,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: 'Discover Our New Guided Meditation Series',
                      style: GoogleFonts.fraunces(
                          fontSize: 32.sp, fontWeight: FontWeight.w600),
                    ),
                    8.verticalSpace,
                    ImageWidget(
                      imageUrl: Assets.images.pngs.videoThumbail.path,
                      height: 193,
                      width: 1.sw,
                    ),
                    8.verticalSpace,
                    const TextView(
                      text: lorem,
                      fontSize: 16,
                      color: Pallets.navy,
                    ),
                  ],
                ),
              ),
            ),
            CustomNeumorphicButton(
              onTap: () {},
              color: Pallets.primary,
              text: 'Learn More',
            )
          ],
        ),
      ),
    );
  }
}
