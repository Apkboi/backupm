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
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class PasswordResetVerificationScreen extends StatefulWidget {
  const PasswordResetVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<PasswordResetVerificationScreen> createState() =>
      _PasswordResetVerificationScreenState();
}

class _PasswordResetVerificationScreenState
    extends State<PasswordResetVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

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
                          'Thank you! 📧 We\'ve sent a one-time verification code to ${widget.email}. Please check your email and enter the code here.',
                        ], isSender: false),
                        16.verticalSpace,
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child:
                          BlocConsumer<PasswordResetBloc, PasswordResetState>(
                        bloc: _bloc,
                        listener: _listenToPasswordResetBloc,
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
                                size: 20,
                              ),
                            ),
                            // onChanged: widget.onChanged,
                            // onFieldSubmitted: widget.onFieldSubmitted,
                            // onSaved: widget.onSaved,
                            radius: 50,
                            // preffix: const Icon(Iconsax.search_normal4),
                            // contentPadding: const EdgeInsets.symmetric(
                            //     vertical: 4, horizontal: 10),
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

      _bloc.add(VerifyPasswordResetOtpEvent(
          email: widget.email, otp: _controller.text.trim()));
    }
  }

  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is VerifyPasswordResetOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is VerifyPasswordResetOtpSuccessState) {
      context.pop();
      context.pushNamed(PageUrl.passwordResetScreen);
    }

    if (state is VerifyPasswordResetOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
