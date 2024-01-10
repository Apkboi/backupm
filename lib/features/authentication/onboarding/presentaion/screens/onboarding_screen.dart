import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/widgets/indicator.dart';
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
        body: Column(
      children: [
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 30),
        //     child: TextButton(
        //         onPressed: () {
        //           context.goNamed(PageUrl.signUp);
        //         },
        //         child: const TextView(
        //           text: 'Skip',
        //           fontSize: 15,
        //           fontWeight: FontWeight.w500,
        //           color: Pallets.grey60,
        //         )),
        //   ),
        // ),
        SizedBox(
          height: 0.7.sh,
          child: CarouselSlider(
              // controller: _pageController,
              options: CarouselOptions(
                viewportFraction: 1,
                height: 0.7.sh,
                autoPlay: true,
                // scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.easeInCirc,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 300),
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
                  img: Assets.images.svgs.onboarding1,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Indicator(
                  seledtedIndex: _currentIndex,
                  items_count: 3,
                ),

                const CustomNeumorphicButton(),

                // CustomButton(
                //   padding: const EdgeInsets.all(18),
                //   isExpanded: true,
                //   borderRadius: BorderRadius.circular(10),
                //   onPressed: () {
                //     switchPage();
                //   },
                //   child: TextView(
                //     text: _currentIndex == 2 ? 'Continue' : 'Next',
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),

                CustomButton(
                  padding: const EdgeInsets.all(18),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    switchPage();
                  },
                  child: TextView(
                    text: _currentIndex == 2 ? 'Continue' : 'Next',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
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
