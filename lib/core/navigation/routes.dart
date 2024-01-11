import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:mentra/features/authentication/login/presentation/screens/passcode_screen.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/onboarding_screen.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/signup_intro.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

class CustomRoutes {
  static final goRouter = GoRouter(
    initialLocation: '/splash',
    // initialLocation: '/profile/setupProfileIntroPage/setupProfilePage',
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: PageUrl.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onBoardingPage',
        name: PageUrl.onBoardingPage,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signUp',
        name: PageUrl.signUp,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: '/login',
        name: PageUrl.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signUpIntro',
        name: PageUrl.signUpIntro,
        builder: (context, state) => const SignupIntroScreen(),
      ),
      GoRoute(
        path: '/passcodeScreen',
        name: PageUrl.passcodeScreen,
        builder: (context, state) => const PasscodeScreen(),
      ),
    ],
  );
}