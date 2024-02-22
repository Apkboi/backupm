import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/date_selector_widget.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';

class SelectYearScreen extends StatefulWidget {
  const SelectYearScreen({super.key});

  @override
  State<SelectYearScreen> createState() => _SelectYearScreenState();
}

class _SelectYearScreenState extends State<SelectYearScreen> {
  int selectedYear = 0;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const AppBg(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton()),
                    16.verticalSpace,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QuestionBox(message: [
                            ' Verified! Thanks,${injector.get<RegistrationBloc>().registrationPayload.name}. Could you also tell me your year of birth for age verification?',
                          ], isSender: false),
                          // SizedBox(
                          //     height: 200.h,
                          //     child: DateSelectorWidget(
                          //       initialYear: 2000,
                          //       onYearSelected: (year) {
                          //         selectedYear = year;
                          //       },
                          //     )),
                        ],
                      ),
                    ),
                    50.verticalSpace,
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Expanded(child: 0.verticalSpace),
                    //     Expanded(
                    //       flex: 1,
                    //       child: CustomNeumorphicButton(
                    //           onTap: () {
                    //             _goToNextScreen(context);
                    //           },
                    //           color: Pallets.primary,
                    //           text: "Continue"),
                    //     )
                    //   ],
                    // )
                    FilledTextField(
                      hint: "Enter birth year",
                      hasElevation: false,
                      outline: false,
                      controller: _controller,
                      validator:
                          RequiredValidator(errorText: 'Enter birth year').call,
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    // if (selectedYear == 0) {
    //   CustomDialogs.showToast('Please select a date');
    // } else {
    injector
        .get<RegistrationBloc>()
        .updateFields(birthYear: _controller.text.toString());
    context.pushNamed(PageUrl.setPasscode);
    // }
  }
}
