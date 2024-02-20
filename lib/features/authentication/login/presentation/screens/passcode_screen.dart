import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/utils/string_extension.dart';
import 'package:mentra/features/account/presentation/profile_image_widget.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  final _pinController = PINController();

  var activeCount = -1;
  final _loginBloc = LoginBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AppBg(),
          SingleChildScrollView(
            child: BlocConsumer<LoginBloc, LoginState>(
              bloc: _loginBloc,
              listener: _listenToLoginBloc,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    0.15.sh.verticalSpace,
                    ProfileImageWidget(
                      size: 80,
                      bgColor: injector
                                  .get<LoginBloc>()
                                  .userPreview
                                  ?.avatarBackgroundColor !=
                              null
                          ? injector
                                  .get<LoginBloc>()
                                  .userPreview
                                  ?.avatarBackgroundColor
                                  .toString()
                                  .toColor() ??
                              Colors.orange
                          : Colors.orange,
                      imageUrl: injector.get<LoginBloc>().userPreview!.avatar,
                      // imageUrl: "${injector.get<LoginBloc>().userPreview?.avatar}"
                    ),
                    7.verticalSpace,
                    Center(
                      child: TextView(
                        text:
                            'Welcome ${injector.get<LoginBloc>().userPreview?.name}',
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
                    16.verticalSpace,
                    TextView(
                      text: "Forgot password ?",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),

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
                        checkPin(val);
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
                      onLastIconClicked: (val) {},
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void checkPin(String pin) async {
    _loginBloc.add(LoginUserEvent(
        email: "${injector.get<LoginBloc>().userPreview?.email}",
        password: pin));
    // injector.get<CacheCubit>().validatePin(pin);
  }

  void _listenToLoginBloc(BuildContext context, LoginState state) async {
    if (state is LoginLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is LoginSuccessState) {
      context.pop();

      await context.pushNamed(PageUrl.welcomeScreen);
    }

    if (state is LoginFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
      _pinController.resetPin();
    }
  }
}
