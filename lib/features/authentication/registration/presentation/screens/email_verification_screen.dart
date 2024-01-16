import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
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
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        16.verticalSpace,
                        QuestionBox(message: [
                          'Thank you! 📧 We\'ve sent a one-time verification code to ${injector.get<RegistrationBloc>().registrationPayload.email}. Please check your email and enter the code here.',
                        ], isSender: false),
                        100.verticalSpace,
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: BlocConsumer<RegistrationBloc, RegistrationState>(
                        bloc: _bloc,
                        listener: _listenToRegistrationBloc,
                        builder: (context, state) {
                          return FilledTextField(
                            hint: "Enter code",
                            hasElevation: false,
                            outline: false,
                            controller: _controller,
                            validator:
                                RequiredValidator(errorText: 'Enter code').call,
                            hasBorder: false,
                            inputType: TextInputType.number,
                            suffix: InkWell(
                              onTap: () {
                                _goToNextScreen(context);
                              },
                              child: const Icon(
                                Icons.send_rounded,
                                size: 25,
                              ),
                            ),
                            // onChanged: widget.onChanged,
                            // onFieldSubmitted: widget.onFieldSubmitted,
                            // onSaved: widget.onSaved,
                            radius: 43,
                            // preffix: const Icon(Iconsax.search_normal4),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            fillColor: Pallets.white,
                          );
                        },
                      ),
                    )
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
      // context.pushNamed(PageUrl.selectYearScreen);

      _bloc.add(VerifyOtpEvent(
          email: injector.get<RegistrationBloc>().registrationPayload.email,
          otp: _controller.text.trim()));
    }
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is VerifyOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is VerifyOtpSuccessState) {
      context.pop();
      // injector.get<RegistrationBloc>().updateFields(email: injector.);
      // CustomDialogs.success('Verification code sent');

      context.pushNamed(PageUrl.selectYearScreen);
    }

    if (state is VerifyOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
