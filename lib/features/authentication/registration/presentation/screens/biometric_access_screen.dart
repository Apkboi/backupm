import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/message_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class BiometricAccessScreen extends StatefulWidget {
  const BiometricAccessScreen({super.key});

  @override
  State<BiometricAccessScreen> createState() => _BiometricAccessScreenState();
}

class _BiometricAccessScreenState extends State<BiometricAccessScreen> {
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
                  16.verticalSpace,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const MessageBox(message: [
                          'Perfect match! 👍 Fancy enabling biometrics or Face ID for a smoother experience?',
                        ], isSender: false),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(
                            foregroundColor: Pallets.black,
                            bgColor: Pallets.white,
                            elevation: 0,
                            isExpanded: false,
                            padding: const EdgeInsets.all(16),
                            borderRadius: BorderRadius.circular(100),
                            child: TextView(
                              text: 'Yes, please!',
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600, fontSize: 14.sp),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        16.verticalSpace,
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(
                            foregroundColor: Pallets.black,
                            bgColor: Pallets.white,
                            elevation: 0,
                            isExpanded: false,
                            padding: const EdgeInsets.all(16),
                            borderRadius: BorderRadius.circular(100),
                            child: TextView(
                              text: 'No,  not now',
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600, fontSize: 14.sp),
                            ),
                            onPressed: () {
                              context.pushNamed(PageUrl.notificationAccess);
                            },
                          ),
                        ),
                        100.verticalSpace,
                      ],
                    ),
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