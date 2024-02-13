import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

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
                          const QuestionBox(message: [
                            'Hello! I\'m Mentra, your personal guide to better mental health. 😊 ',
                            "😊 Let's get to know each other better. What’s your name, please?"
                          ], isSender: false),
                          16.verticalSpace,
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: FilledTextField(
                        hint: "Type name..",
                        controller: _nameController,
                        validator: RequiredValidator(errorText: 'Enter your name').call,
                        hasElevation: false,
                        outline: false,

                        hasBorder: false,
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
                        radius: 43,
                        // preffix: const Icon(Iconsax.search_normal4),
                        // contentPadding: const EdgeInsets.symmetric(
                        //     vertical: 4, horizontal: 10),
                        fillColor: Pallets.white,
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
    log('message');
    if (_formKey.currentState!.validate()) {
      injector.get<RegistrationBloc>().updateFields(name: _nameController.text);
      context.pushNamed(PageUrl.signupOptionScreen);
    }
  }
}
