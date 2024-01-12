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

class UserEmailScreen extends StatefulWidget {
  const UserEmailScreen({super.key, required this.email});

  final String email;

  @override
  State<UserEmailScreen> createState() => _UserEmailScreenState();
}

class _UserEmailScreenState extends State<UserEmailScreen> {
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
                      'Sweet choice! To make sure we\'re all set, we just need your email. Can you share it with us?',
                    ], isSender: false),
                    Expanded(child: 0.verticalSpace),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: FilledTextField(
                        hint: "Type email here..",
                        hasElevation: false,
                        outline: false,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Enter email'),
                          EmailValidator(errorText: 'Invalid email')
                        ]).call,
                        hasBorder: false,
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
      context.pushNamed(PageUrl.emailVerificationScreen);
    }
  }
}
