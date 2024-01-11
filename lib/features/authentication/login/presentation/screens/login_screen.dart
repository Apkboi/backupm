import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft, child: CustomBackButton()),
                  20.verticalSpace,
                  // Align(child: IconButton(onPressed: onPressed, icon: icon),),
                  TextView(
                    text: 'Hey there! Log into your account',
                    style: GoogleFonts.fraunces(
                        fontSize: 32.sp, fontWeight: FontWeight.w600),
                  ),
                  24.verticalSpace,
                  const FilledTextField(
                    labelText: 'Enter your email',
                    fillColor: Pallets.white,
                    hint: "",
                    // hasElevation: false,

                    hasBorder: false,
                  ),
                  16.verticalSpace,
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: 'By continuing, you agree to Mentra’s ',
                        style: GoogleFonts.plusJakartaSans(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy ',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                                color: Pallets.red,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: ' and',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(),
                          ),
                          TextSpan(
                            text: ' Terms of Service',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: const TextStyle(
                                color: Pallets.red,
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                  ),
                  17.verticalSpace,
                  CustomNeumorphicButton(
                    onTap: () {
                      context.pushNamed(PageUrl.passcodeScreen);
                    },
                    color: Pallets.primary,
                    text: 'Continue',
                  ),
                  24.verticalSpace,
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(height: 8, color: Pallets.turquoise1),
                      ),
                      5.horizontalSpace,
                      TextView(
                        text: 'OR',
                        style: GoogleFonts.plusJakartaSans(fontSize: 11.sp),
                      ),
                      5.horizontalSpace,
                      const Expanded(
                        child: Divider(height: 8, color: Pallets.turquoise1),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  CustomButton(
                    foregroundColor: Pallets.black,
                    bgColor: Pallets.white,
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    borderRadius: BorderRadius.circular(100),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageWidget(
                          imageUrl: Assets.images.svgs.apple,
                          size: 15,
                        ),
                        5.horizontalSpace,
                        TextView(
                          text: 'Continue with Apple',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                  16.verticalSpace,
                  CustomButton(
                    foregroundColor: Pallets.black,
                    bgColor: Pallets.white,
                    elevation: 0,
                    padding: const EdgeInsets.all(16),
                    borderRadius: BorderRadius.circular(100),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageWidget(
                          imageUrl: Assets.images.svgs.google,
                          size: 15,
                        ),
                        5.horizontalSpace,
                        TextView(
                          text: 'Continue with Google',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}