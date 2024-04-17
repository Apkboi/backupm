import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

enum PinMode {
  setPin,
  confirmPin,
}

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = PINController();
  PinMode pinMode = PinMode.setPin;
  int activeCount = -1;
  String pin = '';
  String conFirmPin = '';
  final _bloc = PasswordResetBloc(injector.get());

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
              child: Form(
                key: _formKey,
                child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
                  bloc: _bloc,
                  listener: _listenToPasswordResetBloc,
                  builder: (context, state) {
                    return Column(
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
                                  ? const QuestionBox(message: [
                                      'Looking good! ',
                                      'Now, let\'s create a secure passcode for your account. Please set up your passcode.',
                                    ], isSender: false)
                                  : const QuestionBox(message: [
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

          _registerUser();
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

  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is ResetPasswordLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ResetPasswordSuccessState) {
      injector.get<RegistrationBloc>().clear();

      context.pop();
      context.pushNamed(PageUrl.biometricAccess);
    }

    if (state is ResetPasswordFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  void _registerUser() {
    injector.get<RegistrationBloc>().updateFields(password: conFirmPin);
    // logger.i(injector.get<RegistrationBloc>().registrationPayload.toJson());
    _bloc.add(const ResetPasswordEvent(code: '', password: ''));
  }
}
