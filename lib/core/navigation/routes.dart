import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:mentra/features/authentication/login/presentation/screens/passcode_screen.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/onboarding_screen.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/signup_intro.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/splash_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/biometric_access_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/email_verification_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/notification_access_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/select_year_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/set_passcode_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/signup_option_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/user_avatar_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/user_email_screen.dart';
import 'package:mentra/features/authentication/registration/presentation/screens/user_name_page.dart';
import 'package:mentra/features/dashboard/presentation/screens/home_screen.dart';
import 'package:mentra/features/dashboard/presentation/screens/menu_screen.dart';

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
      GoRoute(
        path: '/usernameScreen',
        name: PageUrl.usernameScreen,
        builder: (context, state) => const UsernamePage(),
      ),
      GoRoute(
        path: '/biometricAccess',
        name: PageUrl.biometricAccess,
        builder: (context, state) => const BiometricAccessScreen(),
      ),
      GoRoute(
        path: '/emailVerificationScreen',
        name: PageUrl.emailVerificationScreen,
        builder: (context, state) => const EmailVerificationScreen(
          email: 'caj',
        ),
      ),
      GoRoute(
        path: '/notificationAccess',
        name: PageUrl.notificationAccess,
        builder: (context, state) => const NotificationAccessScreen(),
      ),
      GoRoute(
        path: '/selectYearScreen',
        name: PageUrl.selectYearScreen,
        builder: (context, state) => const SelectYearScreen(),
      ),
      GoRoute(
        path: '/setPasscode',
        name: PageUrl.setPasscode,
        builder: (context, state) => const SetPasscodeScreen(),
      ),
      GoRoute(
        path: '/signupOptionScreen',
        name: PageUrl.signupOptionScreen,
        builder: (context, state) => const SignupOptionScreen(),
      ),
      GoRoute(
        path: '/userEmailScreen',
        name: PageUrl.userEmailScreen,
        builder: (context, state) => const UserEmailScreen(email: 'email'),
      ),
      GoRoute(
        path: '/userAvatarScreen',
        name: PageUrl.userAvatarScreen,
        builder: (context, state) => const UserAvatarScreen(),
      ),
      GoRoute(
        path: '/homeScreen',
        name: PageUrl.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/menuScreen',
        name: PageUrl.menuScreen,
        builder: (context, state) => const MenuScreen(),
      ),
    ],
  );
}
