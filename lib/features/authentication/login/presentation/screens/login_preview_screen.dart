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
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';

class LoginPreviewScreen extends StatefulWidget {
  const LoginPreviewScreen({
    super.key,
  });

  @override
  State<LoginPreviewScreen> createState() => _LoginPreviewScreenState();
}

class _LoginPreviewScreenState extends State<LoginPreviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  // final _bloc = RegistrationBloc(injector.get());

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
                          'Fantastic! Let\'s get you logged in. Please provide your email.',
                        ], isSender: false),
                        16.verticalSpace,
                      ],
                    )),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: _listenToLoginBloc,
                      bloc: injector.get(),
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
                                _getUserDetails();
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

  void _getUserDetails() {
    if (_formKey.currentState!.validate()) {
      injector
          .get<LoginBloc>()
          .add(LoginPreviewEvent(email: _controller.text.trim()));
    }
  }



  void _listenToLoginBloc(BuildContext context, LoginState state) {
    if (state is LoginPreviewSuccessState) {
      context.pop();
      context.pushNamed(PageUrl.passcodeScreen);
    }

    if (state is LoginPreviewFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
