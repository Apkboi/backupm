import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/message_box.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

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
                    const MessageBox(message: [
                      'Thank you! 📧 We\'ve sent a one-time verification code to [Email Address]. Please check your email and enter the code here.',
                    ], isSender: false),
                    Expanded(child: 0.verticalSpace),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: FilledTextField(
                        hint: "Enter code",
                        hasElevation: false,
                        outline: false,
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
    // log('message');
    if (_formKey.currentState!.validate()) {
      context.pushNamed(PageUrl.selectYearScreen);
    }
  }
}
