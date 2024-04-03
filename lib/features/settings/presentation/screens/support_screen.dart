import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/helper_utils.dart';
import 'package:mentra/features/account/dormain/usecases/refresh_user_usecase.dart';
import 'package:mentra/gen/assets.gen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void didChangeDependencies() {
    RefreshUserUsecase().execute();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    RefreshUserUsecase().execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Support',
      ),
      body: Stack(
        children: [
          const AppBg(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        color: Pallets.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 20),
                      child: Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: GoogleFonts.plusJakartaSans(
                                      color: Pallets.black80,
                                      height: 1.5,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                const TextSpan(
                                    text:
                                        'For any assistance, inquiries, or feedback, please reach out to us via email at '),
                                TextSpan(
                                    text: 'support@yourmentra.com.\n',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Helpers.launchEmailWithMessage(
                                            email: 'support@yourmentra.com');
                                      },
                                    style: const TextStyle(
                                        color: Colors.orange,
                                        decoration: TextDecoration.underline)),
                                const TextSpan(
                                    text:
                                        'Our dedicated support team is committed to ensuring that your experience with our product/service is seamless and satisfactory. We strive to respond to all inquiries promptly and provide the assistance you need within two working days.'),
                              ])),
                          42.verticalSpace
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomNeumorphicButton(
                    onTap: () {
                      Helpers.launchEmailWithMessage(
                          email: 'support@yourmentra.com');
                    },
                    color: Pallets.primary,
                    text: 'Email Support',
                  ),
                  10.verticalSpace,
                  CustomNeumorphicButton(
                    onTap: () {},
                    color: Pallets.secondary,
                    fgColor: Pallets.black,
                    text: 'Chat Now',
                  ),
                  10.verticalSpace
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
