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
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class PasswordResetEmailScreen extends StatefulWidget {
  const PasswordResetEmailScreen({super.key, required this.email});

  final String email;

  @override
  State<PasswordResetEmailScreen> createState() =>
      _PasswordResetEmailScreenState();
}

class _PasswordResetEmailScreenState extends State<PasswordResetEmailScreen> {
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
                    16.verticalSpace,
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const QuestionBox(message: [
                          'Resetting your password is easy. To get started, please provide the email address associated with your account.',
                        ], isSender: false),
                        16.verticalSpace,
                      ],
                    )),
                    BlocConsumer<PasswordResetBloc, PasswordResetState>(
                      listener: _listenToPasswordResetBloc,
                      bloc: _bloc,
                      builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: FilledTextField(
                            hint: "Type email here..",
                            hasElevation: false,
                            controller: _controller,
                            outline: false,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Enter email'),
                              EmailValidator(errorText: 'Invalid email')
                            ]).call,
                            hasBorder: false,
                            suffix: InkWell(
                              onTap: () async {
                                _goToNextScreen(context);
                              },
                              child: const Icon(
                                Icons.send_rounded,
                                size: 20,
                              ),
                            ),
                            radius: 50,
                            // preffix: const Icon(Iconsax.search_normal4),
                            // contentPadding: const EdgeInsets.symmetric(
                            //     vertical: 16, horizontal: 16),
                            fillColor: Pallets.white,
                          ),
                        );
                      },
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
      _bloc.add(SendPasswordResetOtpEvent(email: _controller.text.trim()));
    }
  }

  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is PasswordResetOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is PasswordResetOtpSuccessState) {
      context.pop();
      context.pushNamed(PageUrl.passwordResetEmailVerificationScreen,
          queryParameters: {PathParam.email: _controller.text});
    }

    if (state is PasswordResetOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
