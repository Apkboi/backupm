import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';

enum ChangePasscodeMode {
  oldPin,
  setPin,
  confirmPin,
}

class ChangePasscodeScreen extends StatefulWidget {
  const ChangePasscodeScreen({super.key});

  @override
  State<ChangePasscodeScreen> createState() => _ChangePasscodeScreenState();
}

class _ChangePasscodeScreenState extends State<ChangePasscodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = PINController();
  ChangePasscodeMode pinMode = ChangePasscodeMode.oldPin;
  int activeCount = -1;
  String oldPin = '';
  String pin = '';
  String? hash;
  String conFirmPin = '';
  final _bloc = SettingsBloc(injector.get());

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
                child: BlocConsumer<SettingsBloc, SettingsState>(
                  bloc: _bloc,
                  listener: _listenToSettingsState,
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: CustomBackButton()),
                        16.verticalSpace,
                        // Expanded(child: 0.verticalSpace),

                        if (pinMode == ChangePasscodeMode.oldPin)
                          TextView(
                            text: "Enter your login\npasscode.",
                            style: GoogleFonts.fraunces(
                                fontSize: 32.sp, fontWeight: FontWeight.w600),
                            align: TextAlign.center,
                          ),
                        if (pinMode == ChangePasscodeMode.setPin)
                          Column(
                            children: [
                              TextView(
                                text: "Set your login passcode.",
                                style: GoogleFonts.fraunces(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w600),
                                align: TextAlign.center,
                              ),
                              10.verticalSpace,
                              const TextView(
                                text:
                                    "This will be used to access your account securely",
                                align: TextAlign.center,
                              ),
                            ],
                          ),
                        if (pinMode == ChangePasscodeMode.confirmPin)
                          Column(
                            children: [
                              TextView(
                                text: "Confirm your login passcode.",
                                style: GoogleFonts.fraunces(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w600),
                                align: TextAlign.center,
                              ),
                              10.verticalSpace,
                              const TextView(
                                text: "Re-enter your passcode to confirm.",
                                align: TextAlign.center,
                              ),
                            ],
                          ),

                        50.verticalSpace,
                        PinDots(activeCount: activeCount),
                        // OtpField(
                        //   obscureText: true,
                        // ),
                        16.verticalSpace,
                        PinView(
                          onDigitPressed: (pin) {},
                          hasPinField: false,
                          onDelete: () {},
                          aspectRatio: 1.3,
                          onDone: (val) {
                            // checkPin(context, val);
                          },
                          hasBiometric: true,
                          pinController: _pinController,
                          lastIconWidget: ImageWidget(
                              imageUrl: Assets.images.svgs.forwardButton),
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
                          onLastIconClicked: (val) {
                            if (val.length < 4) {
                              CustomDialogs.showToast('Passcode incomplete');
                            } else {
                              checkPin(context, val);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkPin(BuildContext context, String val) {
    if (pinMode == ChangePasscodeMode.oldPin) {
      setState(() {
        oldPin = val;
        // pinMode = ChangePasscodeMode.setPin;
        _verifyPasscode();
      });
    } else if (pinMode == ChangePasscodeMode.setPin) {
      setState(() {
        pin = val;
        pinMode = ChangePasscodeMode.confirmPin;
        _pinController.resetPin();
      });
    } else {
      if (pinMode == ChangePasscodeMode.confirmPin) {
        if (pin == val) {
          conFirmPin = val;
          // pinMode = ChangePasscodeMode.confirmPin;
          setState(() {});
          _updatePasscode();
        } else {
          pin = '';
          conFirmPin = '';
          pinMode = ChangePasscodeMode.setPin;
          setState(() {});
          CustomDialogs.showToast('Passcode mismatch');
        }
      }
    }
  }

  void _listenToSettingsState(BuildContext context, SettingsState state) {
    if (state is VerifyPasscodeSuccessState) {
      hash = state.response.data.hash;
      pinMode = ChangePasscodeMode.setPin;
      _pinController.resetPin();

      setState(() {});
      context.pop();
      CustomDialogs.success('Passcode correct');
      // CustomDialogs.showLoading(context);
    }
    if (state is UpdatePasscodeSuccessState) {
      context.pop();
      context.pop();
      CustomDialogs.success(state.response.message);
    }
    if (state is UpdatePasscodeLoadingState ||
        state is VerifyPasscodeLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is UpdatePasscodeFailureState) {
      context.pop();
      _pinController.resetPin();
      pinMode = ChangePasscodeMode.oldPin;
      CustomDialogs.error(state.error);
    }
    if (state is VerifyPasscodeFailureState) {
      pinMode = ChangePasscodeMode.oldPin;
      _pinController.resetPin();

      context.pop();
      setState(() {});

      CustomDialogs.error(state.error);
    }
    if (state is UpdatePasscodeFailureState) {
      pinMode = ChangePasscodeMode.setPin;
      context.pop();
      setState(() {});
      CustomDialogs.error(state.error);
    }
  }

  void _updatePasscode() {
    _bloc.add(UpdatePasscodeEvent(
        hash: hash!, passcode: pin, passcodeConfirmation: conFirmPin));
  }

  void _verifyPasscode() {
    _bloc.add(VerifyPasscodeEvent(
      passcode: oldPin,
    ));
  }
}
