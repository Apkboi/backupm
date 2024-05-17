import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/dashboard/presentation/bloc/deep_link_bloc/deep_link_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int countdown = 5;
  int countdown2 = 1;

  bool _isExhaling = false;

  @override
  void initState() {
    super.initState();

    injector.get<DeepLinkBloc>().add(CheckForDeepLink());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _updateTimer();
          _isExhaling = !_isExhaling;
          _controller.reverse().then((value) {
            _isExhaling = !_isExhaling;
            _updateTimer();
            _controller.reset();
            _controller.forward();
          });

          // log(countdown.toString());

          // Animation completed, restart the countdown and scale animation
          // if(countdown == 5){
          //   _controller.reset();
          //   _controller.forward();
          // }else{
          //
          // }
        }
      });

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // canPop: false,
      onWillPop: () async {
        context.goNamed(PageUrl.homeScreen);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const AppBg(),
            Column(
              children: [
                Column(
                  children: [
                    0.15.sh.verticalSpace,
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            height: 1.sw,
                            child: Stack(
                              children: [
                                Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: CircleAvatar(
                                    radius: 0.5.sw - 10,
                                    backgroundColor:
                                        Pallets.primary.withOpacity(0.4),
                                    child: CircleAvatar(
                                      radius: 0.5.sw - 50,
                                      backgroundColor: Pallets.white,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Transform.scale(
                                              scale: _scaleAnimation.value,
                                              child: CircleAvatar(
                                                radius: 0.5.sw - 60,
                                                backgroundColor:
                                                    Pallets.secondary,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              countdown.toString(),
                                              style: GoogleFonts.fraunces(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 32.0,
                                                  color: Pallets.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextView(
                      align: TextAlign.center,
                      fontSize: 15.sp,
                      text:
                          'You\'re doing great, ${injector.get<UserBloc>().appUser?.name}.\n ${_isExhaling ? "Exhale stress" : " Inhale positivity"} ',
                      fontWeight: FontWeight.w500,
                    ),
                    50.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomNeumorphicButton(
                        onTap: () {
                          context.goNamed(PageUrl.homeScreen);
                        },
                        color: Pallets.primary,
                        text: 'Skip',
                      ),
                    ),
                    40.verticalSpace,
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _updateTimer() {
    if (countdown == 0) {
      countdown = 5;
      setState(() {});
    } else {
      setState(() {
        // Update the countdown every second
        countdown = countdown - 1;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
