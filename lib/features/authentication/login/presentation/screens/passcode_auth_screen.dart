import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/utils/string_extension.dart';
import 'package:mentra/features/account/presentation/profile_image_widget.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/local_auth/presentation/blocs/local_auth/local_auth_cubit.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';

class PasscodeAuthScreen extends StatefulWidget {
  const PasscodeAuthScreen({Key? key}) : super(key: key);

  @override
  State<PasscodeAuthScreen> createState() => _PasscodeAuthScreenState();
}

class _PasscodeAuthScreenState extends State<PasscodeAuthScreen> {
  final _pinController = PINController();

  var activeCount = -1;
  final _loginBloc = LoginBloc(injector.get());

  String pinCode = '';

  @override
  void initState() {
    injector
        .get<PusherCubit>()
        .subscribeToChannel(injector.get<UserBloc>().userChannel);

    CallKitService.instance.checkAndNavigationCallingPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AppBg(),
          SingleChildScrollView(
            child: BlocListener<UserBloc, UserState>(
              bloc: injector.get<UserBloc>(),
              listener: _listenToUserBloc,
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
                            .get<UserBloc>()
                            .appUser
                            ?.avatarBackgroundColor
                            .toString()
                            .toColor(),
                        imageUrl: injector.get<UserBloc>().appUser?.avatar,
                        // imageUrl: "${injector.get<LoginBloc>().userPreview?.avatar}"
                      ),
                      7.verticalSpace,
                      Center(
                        child: TextView(
                          text:
                              'Welcome ${injector.get<UserBloc>().appUser?.name}',
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
                          onPressed: () {
                            context.pushNamed(PageUrl.botChatScreen,
                                queryParameters: {
                                  PathParam.botChatFlow:
                                      BotChatFlow.passwordReset.name
                                });
                          },
                          child: TextView(
                            text: 'Tap to reset',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          )),
                      PinView(
                        onDigitPressed: (pin) {
                          // pinCode = pin.toString();
                        },
                        hasPinField: false,
                        onDelete: () {},
                        lastIconWidget: ImageWidget(
                            imageUrl: SessionManager.instance.bioMetricEnabled
                                ? Assets.images.svgs.biometricBtn
                                : Assets.images.svgs.forwardButton),
                        onDone: (val) {
                          pinCode = val;
                          if (SessionManager.instance.bioMetricEnabled) {
                            checkPin(val);
                          }
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
                        onLastIconClicked: (val) {
                          if (SessionManager.instance.bioMetricEnabled) {
                            _authenticateWithBioMetric();
                          } else {
                            checkPin(pinCode);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkPin(String pin) async {
    if (pin.length < 4) {
      CustomDialogs.error('Pin is incomplete');
    } else {
      _loginBloc.add(LoginUserEvent(
          email: "${injector.get<UserBloc>().appUser?.email}", password: pin));
    }

    // injector.get<CacheCubit>().validatePin(pin);
  }

  void _listenToLoginBloc(BuildContext context, LoginState state) async {
    if (state is LoginLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is LoginSuccessState) {
      context.pop();

      context.goNamed(PageUrl.welcomeScreen);
    }

    if (state is LoginFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
      _pinController.resetPin();
    }
  }

  void _authenticateWithBioMetric() async {
    var bioMetricAuthenticated =
        await injector.get<LocalAuthCubit>().authenticateUser();

    if (bioMetricAuthenticated) {
      var passcode = await SessionManager.instance.userPassKeyGet;
      if (passcode != null) {
        _loginBloc.add(LoginUserEvent(
            email: injector.get<UserBloc>().appUser!.email,
            password: passcode));
      } else {
        injector.get<UserBloc>().add(GetRemoteUser());
        // context.goNamed(PageUrl.welcomeScreen);
      }
    }
  }

  void _listenToUserBloc(BuildContext context, UserState state) {
    if (state is UserProfileLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is UserCachedState) {
      // context.pop();
      context.goNamed(PageUrl.welcomeScreen);
    }

    if (state is GetProfileFailedState) {
      context.pop();
      CustomDialogs.error(state.error);
      _pinController.resetPin();
    }
  }
}
