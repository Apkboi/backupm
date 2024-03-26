import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';

class ChangeTherapistScreen extends StatefulWidget {
  const ChangeTherapistScreen({
    super.key,
  });

  @override
  State<ChangeTherapistScreen> createState() => _ChangeTherapistScreenState();
}

class _ChangeTherapistScreenState extends State<ChangeTherapistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _bloc = RegistrationBloc(injector.get());

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
                        const QuestionBox(message: [
                          'Hi Mentra, I\'d like to change my therapist.',
                        ], isSender: true),
                         QuestionBox(message: [
                          'Hey ${injector.get<UserBloc>().appUser?.name}!',
                          'Of course, I\'m here to help. Before we proceed, may I ask if you have specific preferences in mind for your new therapist?',
                        ], isSender: false),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(
                            foregroundColor: Pallets.black,
                            bgColor: Pallets.white,
                            isExpanded: false,
                            elevation: 0,
                            padding: const EdgeInsets.all(16),
                            borderRadius: BorderRadius.circular(100),
                            child: TextView(
                              text: 'Yes, update my  preference',
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600, fontSize: 14.sp),
                            ),
                            onPressed: () {
                              context.pushNamed(PageUrl.userPreferenceScreen,
                                  queryParameters: {
                                    PathParam.userPreferenceFlow:
                                        UserPreferenceFlow.changeTherapist.name
                                  });
                            },
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
                              text: 'No, keep as it is',
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600, fontSize: 14.sp),
                            ),
                            onPressed: () {
                              context.pushNamed(PageUrl.matchTherapistScreen,
                                  queryParameters: {
                                    PathParam.updatedPreference: 'false'
                                  });
                            },
                          ),
                        ),
                        100.verticalSpace,
                      ],
                    )),
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
    // log('message');
    if (_formKey.currentState!.validate()) {
      _bloc.add(SendOtpEvent(email: _controller.text.trim()));
    }
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is SendOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is SendOtpSuccessState) {
      context.pop();
      injector.get<RegistrationBloc>().updateFields(email: _controller.text);
      // CustomDialogs.success('Verification code sent');

      context.pushNamed(PageUrl.emailVerificationScreen);
    }

    if (state is SendOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
