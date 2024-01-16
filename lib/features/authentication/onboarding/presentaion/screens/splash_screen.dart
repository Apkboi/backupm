import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/theme/pallets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  late Animation<double> animation;
  AnimationController? animationCtrl;

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: animationCtrl!,
        curve: Curves.easeIn,
      ),
    );

    // Future.delayed(Duration.zero, () {
    //
    //   ref.read(setupProfileProvider.notifier).getDataConfigs();
    //   // ref.read(locationProvider.notifier).caller();
    // });

    animationCtrl?.forward();
    animation.addListener(() async {
      if (animation.isCompleted ?? false) {
        _goToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    dialogKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(color: Pallets.turquoise1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: 'Mentra',
                style: GoogleFonts.caveat(
                    fontSize: 58.sp,
                    fontWeight: FontWeight.w700,
                    color: Pallets.primary),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToNextScreen() {
    // context.pushReplacementNamed(PageUrl.onBoardingPage);
    if (SessionManager.instance.isLoggedIn) {
      context.goNamed(PageUrl.homeScreen);
    } else {
      if (SessionManager.instance.hasOnboarded) {
        context.goNamed(PageUrl.login);
      } else {
        context.goNamed(PageUrl.onBoardingPage);
      }
      // context.pushReplacementNamed(PageUrl.onBoardingPage);
    }
  }
}
