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
import 'package:mentra/features/authentication/registration/presentation/widget/avatar_gridview.dart';
import 'package:mentra/features/authentication/registration/presentation/widget/question_box.dart';

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
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          QuestionBox(message: [
                            'Thanks for sharing! Let\'s add a personal touch. Choose an avatar to represent yourself.',
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
                          child: AvatarGridView(
                            onAvatarSelected: (p0) {
                              setState(() {
                                selectedAvatar = p0;
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
      context.pushNamed(PageUrl.setPasscode);
    } else {
      CustomDialogs.showToast('Please select an avatar');
    }
  }
}
