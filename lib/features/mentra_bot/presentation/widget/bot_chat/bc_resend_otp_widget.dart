import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';


class BcResendOtpWidget extends StatefulWidget {
  const BcResendOtpWidget({
    super.key,
  });

  @override
  State<BcResendOtpWidget> createState() => _BcResendOtpWidgetState();
}

class _BcResendOtpWidgetState extends State<BcResendOtpWidget> {
  final _bloc = RegistrationBloc(injector.get());
  String email = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: _listenToRegistrationBloc,
      bloc: _bloc,
      builder: (context, state) {
        return RichText(
            text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    height: 1.5.h,
                    wordSpacing: 1.5,
                    color: Pallets.white
                    // letterSpacing: 2
                    ),
                children: [
              // const TextSpan(
              //   text: 'Forgot password ? ',
              //   // color: Pallets.secondary,
              //   // fontWeight: FontWeight.w600,
              //   // lineHeight: 1.5,
              // ),
              const TextSpan(
                text: 'Didn\'t get code?',
                // color: Pallets.secondary,
                // fontWeight: FontWeight.w600,
                // lineHeight: 1.5,
              ),
              TextSpan(
                  text: 'Resend Code',
                  // color: Pallets.secondary,
                  // fontWeight: FontWeight.w600,
                  // lineHeight: 1.5,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _bloc.add(SendOtpEvent(
                          email: injector
                              .get<RegistrationBloc>()
                              .registrationPayload
                              .email));
                    },
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    color: Pallets.secondary,
                    fontSize: 14.sp,
                    height: 1.5.h,
                    wordSpacing: 1.5,
                    decoration: TextDecoration.underline,
                    decorationColor: Pallets.secondary,
                    // letterSpacing: 2
                  )),
            ]));
      },
    );
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is SendOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is SendOtpSuccessState) {
      context.pop();
      // injector.get<RegistrationBloc>().updateFields(email: email);
      CustomDialogs.success('Otp Resent');
      // context.read<BotChatCubit>().answerQuestion(
      //     id: 0,
      //     answer: email,
      //     nextSignupStage: SignupStage.EMAIL_VERIFICATION);

      // CustomDialogs.success('Verification code sent');

      // context.pushNamed(PageUrl.emailVerificationScreen);
    }

    if (state is SendOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
