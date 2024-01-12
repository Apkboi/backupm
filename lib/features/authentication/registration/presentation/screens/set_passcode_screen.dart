import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/message_box.dart';
import 'package:mentra/gen/assets.gen.dart';

enum PinMode {
  setPin,
  confirmPin,
}

class SetPasscodeScreen extends StatefulWidget {
  const SetPasscodeScreen({super.key});

  @override
  State<SetPasscodeScreen> createState() => _SetPasscodeScreenState();
}

class _SetPasscodeScreenState extends State<SetPasscodeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _pinController = PINController();
  PinMode pinMode = PinMode.setPin;

  int activeCount = -1;
  String pin = '';
  String conFirmPin = '';

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton()),
                    16.verticalSpace,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          pinMode == PinMode.setPin
                              ? const MessageBox(message: [
                                  'Inhale slowly for a count of four, hold, and exhale for four. Repeat a few times.! 👋 ',
                                  "Looking good! "
                                ], isSender: false)
                              : const MessageBox(message: [
                                  'Well done! To ensure it\'s correct, please confirm your passcode.',
                                ], isSender: false),
                        ],
                      ),
                    ),
                    PinDots(activeCount: activeCount),
                    // OtpField(
                    //   obscureText: true,
                    // ),
                    16.verticalSpace,
                    PinView(
                      onDigitPressed: (pin) {},
                      hasPinField: false,
                      onDelete: () {},
                      onDone: (val) {
                        checkPin(context, val);
                      },
                      hasBiometric: true,
                      pinController: _pinController,
                      lastIconWidget: ImageWidget(
                          imageUrl: Assets.images.svgs.biometricBtn),
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
                      onLastIconClicked: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    log('message');
    if (_formKey.currentState!.validate()) {
      context.pushNamed(PageUrl.signupOptionScreen);
    }
  }

  void checkPin(BuildContext context, String val) {
    if (pinMode == PinMode.setPin) {
      setState(() {
        pin = val;
        pinMode = PinMode.confirmPin;
        _pinController.resetPin();
      });
    } else {
      if (pinMode == PinMode.confirmPin) {
        if (pin == val) {
          conFirmPin = val;
          pinMode = PinMode.confirmPin;
          setState(() {});
          // TODO:UPDATE PIN AND SEND REQUEST;
          //   Move to next Screen
          context.pushNamed(PageUrl.biometricAccess);
        } else {
          pin = '';
          conFirmPin = '';
          pinMode = PinMode.setPin;
          _pinController.resetPin();
          setState(() {});
          CustomDialogs.showToast('Passcode mismatch');
        }
      }
    }
  }
}
