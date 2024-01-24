import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/app_filled_textfield.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/app_styles.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/gen/assets.gen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Profile',
      ),
      body: Stack(
        children: [
          const AppBg(),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: ImageWidget(
                              size: 80,
                              imageUrl: Assets.images.pngs.avatar22.path,
                              // imageUrl: "${injector.get<LoginBloc>().userPreview?.avatar}"
                            ),
                          ),
                          10.verticalSpace,
                          Center(
                            child: TextView(
                              text:
                                  injector.get<UserBloc>().appUser?.name ?? '',
                              style: GoogleFonts.fraunces(
                                fontSize: 32.sp,
                              ),
                            ),
                          ),
                          18.verticalSpace,
                          Center(
                            child: CustomNeumorphicButton(
                                expanded: false,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26, vertical: 10),
                                onTap: () {
                                  context.pushNamed(PageUrl.editProfileScreen);
                                },
                                color: Pallets.buttonBlack,
                                child: const TextView(
                                  text: "Change Avatar",
                                  color: Pallets.white,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          45.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                color: Pallets.white,
                                borderRadius: BorderRadius.circular(17)),
                            padding: const EdgeInsets.all(16),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextView(
                                        text: 'Birth Year',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TextView(
                                        text: '1990',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Pallets.black,
                                )
                              ],
                            ),
                          ),
                          16.verticalSpace,
                          const AppFilledTextField(
                            hint: 'Habib',
                            label: 'Enter your nickname',
                          ),
                          16.verticalSpace,
                          AppFilledTextField(
                              hint: '*******',
                              label: 'Passcode',
                              obscured: _passwordObscured,
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    _passwordObscured = !_passwordObscured;
                                  });
                                },
                                child: Container(
                                  child: !_passwordObscured
                                      ? const Icon(
                                          Icons.remove_red_eye_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                ),
                              )),
                          16.verticalSpace,
                          const AppFilledTextField(
                            hint: 'habib@gmail.com',
                            enabled: false,
                            label: 'Enter your email',
                          ),
                          16.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomNeumorphicButton(
                      text: "Save Changes",
                      onTap: () {},
                      color: Pallets.primary),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
