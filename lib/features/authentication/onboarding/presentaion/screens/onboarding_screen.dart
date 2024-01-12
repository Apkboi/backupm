import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/signup_intro.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/widgets/indicator.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/widgets/language_selection_sheet.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/widgets/onboardinng_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  double progress = 0.25;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const AppBg(),
        Column(
          children: [
            SizedBox(
              height: 0.72.sh,
              child: CarouselSlider(
                  // controller: _pageController,
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 1.sh,
                    autoPlay: true,
                    // scrollDirection: Axis.horizontal,
                    autoPlayCurve: Curves.easeInCirc,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 300),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  // onPageChanged: (index) {
                  //   setState(() {
                  //     _currentIndex = index;
                  //   });
                  // },
                  items: [
                    OnboardingItem(
                      img: Assets.images.pngs.onboarding1.path,
                      header: heading1,
                      text: body1,
                    ),
                    OnboardingItem(
                      img: Assets.images.pngs.onboarding2.path,
                      header: heading2,
                      text: body2,
                    ),
                    OnboardingItem(
                      img: Assets.images.pngs.onboarding3.path,
                      header: heading3,
                      text: body3,
                    ),
                  ]),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Indicator(
                      seledtedIndex: _currentIndex,
                      items_count: 3,
                    ),
                    20.verticalSpace,
                    CustomNeumorphicButton(
                      color: Pallets.primary,
                      text: 'Create an Account',
                      onTap: () {
                        CustomDialogs.showBottomSheet(
                            context, const SignupIntroScreen(),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            )),
                            constraints: BoxConstraints(maxHeight: 0.9.sh));
                        // context.pushNamed(PageUrl.signUpIntro);
                      },
                    ),
                    10.verticalSpace,
                    CustomNeumorphicButton(
                      color: Pallets.secondary,
                      text: 'Login',
                      fgColor: Pallets.black,
                      onTap: () {
                        context.pushNamed(PageUrl.login);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          // alignment: Alignment.topRight,
          right: 20,
          top: 60,
          child: CustomNeumorphicButton(
              onTap: () {
                context.pushNamed(PageUrl.menuScreen);
                // CustomDialogs.showBottomSheet(
                //     context, const LanguageSelectionSheet(),
                //     shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(16),
                //       topRight: Radius.circular(16),
                //     )),
                //     constraints: BoxConstraints(maxHeight: 0.9.sh));
              },
              color: Pallets.primary,
              expanded: false,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'English',
                    style: TextStyle(
                        color: Pallets.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  5.horizontalSpace,
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Pallets.white,
                  )
                ],
              )),
        ),
      ],
    ));
  }

  void switchPage() {
    if (_currentIndex == 2) {
      // StorageHelper.setBoolean(StorageKeys.hasOnBoarded, true);
      SessionManager.instance.hasOnboarded = true;
      context.goNamed(PageUrl.signUp);
    } else {
      setState(() {
        _pageController.jumpToPage(_currentIndex + 1);
      });
    }
  }

  void switchBack() {
    if (_currentIndex != 0) {
      setState(() {
        _pageController.jumpToPage(_currentIndex - 1);
      });
    }
  }
}
