import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/otp_field.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/gen/assets.gen.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  final _pinController = PINController();

  var activeCount = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AppBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              80.verticalSpace,
              ImageWidget(imageUrl: Assets.images.svgs.userEmoji),
              7.verticalSpace,
              Center(
                child: TextView(
                  text: 'Welcome Leila',
                  align: TextAlign.center,
                  style: GoogleFonts.fraunces(
                      fontSize: 32.sp, fontWeight: FontWeight.w600),
                ),
              ),
              7.verticalSpace,
              TextView(
                text: "Enter your passcode",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              36.verticalSpace,
              PinDots(activeCount: activeCount),
              // OtpField(
              //   obscureText: true,
              // ),
              10.verticalSpace,
              TextView(
                text: "Forgot password ?",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              2.verticalSpace,
              TextButton(
                  onPressed: () {},
                  child: TextView(
                    text: 'Tap to reset',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  )),
              PinView(
                onDigitPressed: (pin) {},
                hasPinField: false,
                onDelete: () {},
                onDone: (val) {
                  // checkPin(val);
                },
                hasBiometric: true,
                pinController: _pinController,
                biometricAuthenticated: (bool autheticated) {
                  if (autheticated) {
                    Navigator.pop(context);
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(
                    //       builder: (context) => const AppWrapper()),
                    //       (route) => false,
                    // );
                  }
                },
                onOutput: (count) {
                  setState(() {
                    activeCount = count;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkPin(String pin) async {
    // injector.get<CacheCubit>().validatePin(pin);
  }
}
