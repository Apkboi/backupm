import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class NewPascodeScreen extends StatefulWidget {
  const NewPascodeScreen({
    super.key,
  });

  @override
  State<NewPascodeScreen> createState() => _NewPascodeScreenState();
}

class _NewPascodeScreenState extends State<NewPascodeScreen> {
  final _formKey = GlobalKey<FormState>();
  // final _controller = TextEditingController();
  final _pinController = PINController();
  final _loginBloc = LoginBloc(injector.get());
  int activeCount = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: _listenToLoginBloc,
        builder: (context, state) {
          return Stack(
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
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            16.verticalSpace,
                            QuestionBox(message: [
                              "Welcome ${injector.get<LoginBloc>().userPreview?.name}",
                              "Enter your passcode"
                            ], isSender: false),
                            16.verticalSpace,
                          ],
                        )),
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
                              checkPin(val);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
