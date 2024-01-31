import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/core/navigation/path_params.dart';
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
import 'package:mentra/features/dashboard/presentation/screens/emergency_sos_screen.dart';
import 'package:mentra/features/dashboard/presentation/screens/home_screen.dart';
import 'package:mentra/features/dashboard/presentation/screens/menu_screen.dart';
import 'package:mentra/features/library/presentation/screens/all_articles_screen.dart';
import 'package:mentra/features/library/presentation/screens/article_details_screen.dart';
import 'package:mentra/features/library/presentation/screens/video_article_screen.dart';
import 'package:mentra/features/library/presentation/screens/video_player_screen.dart';
import 'package:mentra/features/library/presentation/screens/wellness_library_screen.dart';
import 'package:mentra/features/mentra_bot/presentation/screens/talk_to_mentra_screen.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/screens/change_passcode_screen.dart';
import 'package:mentra/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:mentra/features/settings/presentation/screens/edit_avatar_screen.dart';
import 'package:mentra/features/settings/presentation/screens/edit_profile_screen.dart';
import 'package:mentra/features/settings/presentation/screens/security_privacy_screen.dart';
import 'package:mentra/features/settings/presentation/screens/settings_screen.dart';
import 'package:mentra/features/settings/presentation/screens/user_preference_screen.dart';
import 'package:mentra/features/subscription/presentation/screens/select_plan_screen.dart';
import 'package:mentra/features/summary/presentation/screens/summaries_screen.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/presentation/screens/accept_therapist_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/change_therapist_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/match_therapist_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapist_chat_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapist_profile_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapy_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
// final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
// final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
// final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
// final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

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
      GoRoute(
        path: '/talkToMentraScreen',
        name: PageUrl.talkToMentraScreen,
        builder: (context, state) => const TalkToMentraScreen(),
      ),
      GoRoute(
        path: '/therapistProfile',
        name: PageUrl.therapistProfile,
        builder: (context, state) => const TherapistProfileScreen(),
      ),
      // GoRoute(
      //   path: '/therapistProfile',
      //   name: PageUrl.therapistProfile,
      //   builder: (context, state) => const TherapistProfileScreen(),
      // ),
      GoRoute(
        path: '/therapyScreen',
        name: PageUrl.therapyScreen,
        builder: (context, state) => const TherapyScreen(),
      ),
      GoRoute(
        path: '/summariesScreen',
        name: PageUrl.summariesScreen,
        builder: (context, state) => const SummariesScreen(),
      ),

      GoRoute(
        path: '/therapistChatScreen',
        name: PageUrl.therapistChatScreen,
        builder: (context, state) => const TherapistChatScreen(),
      ),
      GoRoute(
        path: '/selectPlanScreen',
        name: PageUrl.selectPlanScreen,
        builder: (context, state) => const SelectPlanScreen(),
      ),
      GoRoute(
        path: '/videoPlayerScreen',
        name: PageUrl.videoPlayerScreen,
        builder: (context, state) => const VideoPlayerScreen(),
      ),
      GoRoute(
        path: '/articleDetailsScreen',
        name: PageUrl.articleDetailsScreen,
        builder: (context, state) => ArticleDetailsScreen(
          courseJson: state.uri.queryParameters[PathParam.libraryCourse] ?? "",
        ),
      ),
      GoRoute(
        path: '/wellnessLibraryScreen',
        name: PageUrl.wellnessLibraryScreen,
        builder: (context, state) => const WellnessLibraryScreen(),
      ),
      GoRoute(
        path: '/allArticlesScreen',
        name: PageUrl.allArticlesScreen,
        builder: (context, state) => AllArticlesScreen(
          categoryJson:
              state.uri.queryParameters[PathParam.libraryCategory] ?? "",
        ),
      ),
      GoRoute(
        path: '/videoArticleScreen',
        name: PageUrl.videoArticleScreen,
        builder: (context, state) => const VideoArticleScreen(),
      ),
      GoRoute(
        path: '/settingsScreen',
        name: PageUrl.settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/editProfileScreen',
        name: PageUrl.editProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/deleteAccountScreen',
        name: PageUrl.deleteAccountScreen,
        builder: (context, state) => const DeleteAccountScreen(),
      ),
      GoRoute(
        path: '/editAvatarScreen',
        name: PageUrl.editAvatarScreen,
        builder: (context, state) => const EditAvatarScreen(),
      ),
      GoRoute(
        path: '/securityPrivacyScreen',
        name: PageUrl.securityPrivacyScreen,
        builder: (context, state) => const SecurityPrivacyScreen(),
      ),
      GoRoute(
        path: '/changePasscodeScreen',
        name: PageUrl.changePasscodeScreen,
        builder: (context, state) => const ChangePasscodeScreen(),
      ),
      GoRoute(
        path: '/emergencySosScreen',
        name: PageUrl.emergencySosScreen,
        builder: (context, state) => const EmergencySosScreen(),
      ),
      GoRoute(
        path: '/userPreferenceScreen',
        name: PageUrl.userPreferenceScreen,
        builder: (context, state) => UserPreferenceScreen(
          flow: stringToUserPreferenceFlow(
              state.uri.queryParameters[PathParam.userPreferenceFlow] ?? ''),
        ),
      ),

      GoRoute(
        path: '/changeTherapistScreen',
        name: PageUrl.changeTherapistScreen,
        builder: (context, state) => const ChangeTherapistScreen(),
      ),

      GoRoute(
        path: '/matchTherapistScreen',
        name: PageUrl.matchTherapistScreen,
        builder: (context, state) => MatchTherapistScreen(
          updatedPreference: bool.parse(
              state.uri.queryParameters[PathParam.updatedPreference] ?? '0'),
        ),
      ),
      GoRoute(
        path: '/acceptTherapistScreen',
        name: PageUrl.acceptTherapistScreen,
        builder: (context, state) => AcceptTherapistScreen(
          suggestedTherapist:SuggestedTherapist.fromJson(jsonDecode( state.uri.queryParameters[PathParam.therapist] ?? '')),
        ),
      ),
    ],
  );
}
