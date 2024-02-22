import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_back_button.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';
import 'package:mentra/features/settings/presentation/widgets/avatar_selector_widget.dart';

class UserAvatarScreen extends StatefulWidget {
  const UserAvatarScreen({super.key});

  @override
  State<UserAvatarScreen> createState() => _UserAvatarScreenState();
}

class _UserAvatarScreenState extends State<UserAvatarScreen> {
  String? selectedAvatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const AppBg(),
            SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: CustomBackButton()),
                  ),
                  16.verticalSpace,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                        reverse: true,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          QuestionBox(message: [
                            'Great choice, ${injector.get<RegistrationBloc>().registrationPayload.name}! Next, please choose an avatar that best represents you. We’re constantly adding more options to ensure you find the perfect match',
                          ], isSender: false),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Pallets.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.4.sh,
                          child: AvartarSelector(
                            onBackgroundSelector: (p0) {},
                            onAvatarSelected: (p0) {
                              setState(() {
                                selectedAvatar = p0.image.url;
                              });
                            },
                          ),
                        ),
                        CustomNeumorphicButton(
                            onTap: () {
                              _goToNextScreen(context);
                            },
                            color: Pallets.primary,
                            text: "Continue"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    if (selectedAvatar != null) {
      injector.get<RegistrationBloc>().updateFields(avatarPath: selectedAvatar);
      context.pushNamed(PageUrl.signupOptionScreen);
    } else {
      CustomDialogs.showToast('Please select an avatar');
    }
  }
}
