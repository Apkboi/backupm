import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class SignupIntroScreen extends StatefulWidget {
  const SignupIntroScreen({Key? key}) : super(key: key);

  @override
  State<SignupIntroScreen> createState() => _SignupIntroScreenState();
}

class _SignupIntroScreenState extends State<SignupIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallets.bgLight,
      appBar: const CustomAppBar(
        bgColor: Pallets.bgLight,
        leading: Icon(
          Icons.close,
          color: Pallets.black,
        ),
        tittleText: 'Sign up',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "Start your journey:\nWhat brings you here?",
              style: GoogleFonts.fraunces(
                  fontSize: 32.sp, fontWeight: FontWeight.w600),
            ),
            30.verticalSpace,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Pallets.white),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text:
                              'Here to find support and speak to a specialist',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                        9.verticalSpace,
                        CustomNeumorphicButton(
                            onTap: () {},
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            expanded: false,
                            color: Pallets.primary,
                            text: 'Seeking Support')
                      ],
                    ),
                  ),
                  ImageWidget(
                    imageUrl: Assets.images.pngs.insight.path,
                    size: 0.3.sw,
                    // height: ,
                  )
                ],
              ),
            ),
            16.verticalSpace,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Pallets.white),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: 'Here to provide assistance to those in need.',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                        9.verticalSpace,
                        CustomNeumorphicButton(
                            onTap: () {},
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            expanded: false,
                            color: Pallets.black,
                            text: 'I’m a therapist')
                      ],
                    ),
                  ),
                  16.horizontalSpace,
                  ImageWidget(
                    imageUrl: Assets.images.pngs.brain.path,
                    size: 0.3.sw,
                    // height: ,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
