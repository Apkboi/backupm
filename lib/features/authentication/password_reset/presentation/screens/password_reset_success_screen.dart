import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class PasswordResetSuccessScreen extends StatefulWidget {
  const PasswordResetSuccessScreen();

  @override
  State<PasswordResetSuccessScreen> createState() =>
      _PasswordResetSuccessScreenState();
}

class _PasswordResetSuccessScreenState
    extends State<PasswordResetSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AppBg(image: Assets.images.pngs.homeBg.path),
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
                      const QuestionBox(message: [
                        'Now, could you share your email address with us? We’ll send a verification code to ensure everything’s secure',
                      ], isSender: false),
                      16.verticalSpace,
                    ],
                  )),
                  39.verticalSpace,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomNeumorphicButton(
                        text: "Login",
                        expanded: false,
                        onTap: () {},
                        color: Pallets.primary),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
