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
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/services/permission_handler/permission_handler_service.dart';

class UserEmailScreen extends StatefulWidget {
  const UserEmailScreen({super.key, required this.email});

  final String email;

  @override
  State<UserEmailScreen> createState() => _UserEmailScreenState();
}

class _UserEmailScreenState extends State<UserEmailScreen> {
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
                          'Sweet choice! To make sure we\'re all set, we just need your email. Can you share it with us?',
                        ], isSender: false),
                        100.verticalSpace,
                      ],
                    )),
                    BlocConsumer<RegistrationBloc, RegistrationState>(
                      listener: _listenToRegistrationBloc,
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
                              onTap: () async{

                                _goToNextScreen(context);
                              },
                              child: const Icon(
                                Icons.send_rounded,
                                size: 25,
                              ),
                            ),

                            radius: 43,
                            // preffix: const Icon(Iconsax.search_normal4),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
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
