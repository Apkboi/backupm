import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/utils/bot_chat_flow_helper.dart';
import 'package:mentra/features/authentication/login/presentation/screens/login_preview_screen.dart';
import 'package:mentra/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:mentra/features/authentication/login/presentation/screens/new_login.dart';
import 'package:mentra/features/authentication/login/presentation/screens/new_passcode_screen.dart';
import 'package:mentra/features/authentication/login/presentation/screens/passcode_auth_screen.dart';
import 'package:mentra/features/authentication/login/presentation/screens/welcome_screen.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/onboarding_intro.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/onboarding_screen.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/signup_intro.dart';
import 'package:mentra/features/authentication/onboarding/presentaion/screens/splash_screen.dart';
import 'package:mentra/features/authentication/password_reset/presentation/screens/password_reset_email_screen.dart';
import 'package:mentra/features/authentication/password_reset/presentation/screens/password_reset_screen.dart';
import 'package:mentra/features/authentication/password_reset/presentation/screens/password_reset_success_screen.dart';
import 'package:mentra/features/authentication/password_reset/presentation/screens/password_reset_verification_screen.dart';
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
import 'package:mentra/features/journal/data/models/get_journals_response.dart';
import 'package:mentra/features/journal/data/models/get_prompts_response.dart';
import 'package:mentra/features/journal/presentation/screens/create_journal_screen.dart';
import 'package:mentra/features/journal/presentation/screens/journal_screen.dart';
import 'package:mentra/features/journal/presentation/screens/prompts_category.dart';
import 'package:mentra/features/journal/presentation/widgets/guided_prompts_screen.dart';
import 'package:mentra/features/library/presentation/screens/all_articles_screen.dart';
import 'package:mentra/features/library/presentation/screens/article_details_screen.dart';
import 'package:mentra/features/library/presentation/screens/audio_article_screen.dart';
import 'package:mentra/features/library/presentation/screens/video_article_screen.dart';
import 'package:mentra/features/library/presentation/screens/video_player_screen.dart';
import 'package:mentra/features/library/presentation/screens/wellness_library_screen.dart';
import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

// import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/features/mentra_bot/presentation/screens/bot_chat_screen.dart';
import 'package:mentra/features/mentra_bot/presentation/screens/talk_to_mentra_screen.dart';
import 'package:mentra/features/notification/presentation/screens/notifications_screen.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/settings/presentation/screens/change_passcode_screen.dart';
import 'package:mentra/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:mentra/features/settings/presentation/screens/edit_avatar_screen.dart';
import 'package:mentra/features/settings/presentation/screens/edit_profile_screen.dart';
import 'package:mentra/features/settings/presentation/screens/security_privacy_screen.dart';
import 'package:mentra/features/settings/presentation/screens/settings_screen.dart';
import 'package:mentra/features/settings/presentation/screens/support_screen.dart';
import 'package:mentra/features/settings/presentation/screens/user_preference_screen.dart';
import 'package:mentra/features/streaks/presentation/screens/badges_screen.dart';
import 'package:mentra/features/streaks/presentation/screens/streak_details_screen.dart';
import 'package:mentra/features/subscription/presentation/screens/select_plan_screen.dart';
import 'package:mentra/features/summary/presentation/screens/summaries_screen.dart';
import 'package:mentra/features/therapy/data/models/chat_therapist.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/data/models/match_therapist_response.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/screens/accept_therapist_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/change_therapist_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/match_therapist_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapist_chat_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapist_profile_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapy_call_screen.dart';
import 'package:mentra/features/therapy/presentation/screens/therapy_screen.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/questionaire_screen.dart';
import 'package:mentra/features/work_sheet/presentation/widgets/work_sheet_detail_screen.dart';

import '../../features/subscription/presentation/screens/manage_subscription_screen.dart';

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
        builder: (context, state) => const NewPascodeScreen(),
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
        path: '/loginPreview',
        name: PageUrl.loginPreview,
        builder: (context, state) => const LoginPreviewScreen(),
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
        path: '/passcodeAuthScreen',
        name: PageUrl.passcodeAuthScreen,
        builder: (context, state) => const PasscodeAuthScreen(),
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
        path: '/onboardingIntro',
        name: PageUrl.onboardingIntro,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const OnboardingIntro()),
        // builder: (context, state) => const OnboardingIntro(),
      ),
      GoRoute(
        path: '/newLoginScreen',
        name: PageUrl.newLoginScreen,
        builder: (context, state) => const NewLoginScreen(),
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
        builder: (context, state) => HomeScreen(
          startConvo: bool.parse(
              state.uri.queryParameters[PathParam.startConvo] ?? "false"),
          authenticate: bool.parse(
              state.uri.queryParameters[PathParam.authenticate] ?? "false"),
        ),
      ),
      GoRoute(
        path: '/menuScreen',
        name: PageUrl.menuScreen,
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: '/talkToMentraScreen',
        name: PageUrl.talkToMentraScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: TalkToMentraScreen(
            authMessages: List.from(jsonDecode(
                    state.uri.queryParameters[PathParam.authMessages] ?? '[]'))
                .map((e) => MentraChatModel.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
        // builder: (context, state) => const TalkToMentraScreen(),
      ),
      GoRoute(
        path: '/botChatScreen',
        name: PageUrl.botChatScreen,
        builder: (context, state) => BotChatScreen(
          botChatFlow: BotChatFlowHelper.fromStringValue(
              state.uri.queryParameters[PathParam.botChatFlow] ??
                  BotChatFlow.welcome.name),
        ),
      ),
      GoRoute(
        path: '/therapistProfile',
        name: PageUrl.therapistProfile,
        builder: (context, state) => const TherapistProfileScreen(),
      ),
      GoRoute(
        path: '/welcomeScreen',
        name: PageUrl.welcomeScreen,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
              context: context, state: state, child: WelcomeScreen());
        },
        // builder: (context, state) => ,
      ),
      GoRoute(
        path: '/therapyScreen',
        name: PageUrl.therapyScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const TherapyScreen()),
        // builder: (context, state) => const TherapyScreen(),
      ),
      GoRoute(
        path: '/summariesScreen',
        name: PageUrl.summariesScreen,
        builder: (context, state) => MyActivitiesScreen(
          tabIndex:
              int.parse(state.uri.queryParameters[PathParam.tabIndex] ?? "0"),
        ),
      ),
      GoRoute(
        path: '/therapistChatScreen',
        name: PageUrl.therapistChatScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: TherapistChatScreen(
              therapist: ChatTherapist.fromJson(jsonDecode(
                  state.uri.queryParameters[PathParam.therapist] ?? '')),
            )),
        // builder: (context, state) => const TherapistChatScreen(),
      ),
      GoRoute(
        path: '/selectPlanScreen',
        name: PageUrl.selectPlanScreen,
        builder: (context, state) => const SelectPlanScreen(),
      ),
      GoRoute(
        path: '/videoPlayerScreen',
        name: PageUrl.videoPlayerScreen,
        builder: (context, state) => VideoPlayerScreen(
          courseJson: state.uri.queryParameters[PathParam.libraryCourse] ?? "",
        ),
      ),
      GoRoute(
        path: '/audioArticleScreen',
        name: PageUrl.audioArticleScreen,
        builder: (context, state) => AudioArticleScreen(
          courseJson: state.uri.queryParameters[PathParam.libraryCourse] ?? "",
        ),
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
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const WellnessLibraryScreen()),
        // builder: (context, state) => const WellnessLibraryScreen(),
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
        builder: (context, state) => VideoArticleScreen(
          courseId: state.uri.queryParameters[PathParam.id] ?? "",
        ),
      ),
      GoRoute(
        path: '/settingsScreen',
        name: PageUrl.settingsScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const SettingsScreen()),
        // builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/manageSubscriptionScreen',
        name: PageUrl.manageSubscriptionScreen,
        builder: (context, state) => const ManageSubscriptionScreen(),
      ),
      GoRoute(
        path: '/supportScreen',
        name: PageUrl.supportScreen,
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: '/editProfileScreen',
        name: PageUrl.editProfileScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const EditProfileScreen()),
        // builder: (context, state) => const EditProfileScreen(),
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
          intent: stringToTherapyPreferenceIntent(
              state.uri.queryParameters[PathParam.chatIntent] ?? ''),
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
          suggestedTherapist: SuggestedTherapist.fromJson(
              jsonDecode(state.uri.queryParameters[PathParam.therapist] ?? '')),
        ),
      ),
      GoRoute(
        path: '/passwordResetEmailScreen',
        name: PageUrl.passwordResetEmailScreen,
        builder: (context, state) => PasswordResetEmailScreen(
          email: state.uri.queryParameters[PathParam.email] ?? '',
        ),
      ),
      GoRoute(
        path: '/passwordResetEmailVerificationScreen',
        name: PageUrl.passwordResetEmailVerificationScreen,
        builder: (context, state) => PasswordResetVerificationScreen(
          email: state.uri.queryParameters[PathParam.email] ?? '',
        ),
      ),
      GoRoute(
        path: '/passwordResetScreen',
        name: PageUrl.passwordResetScreen,
        builder: (context, state) => const PasswordResetScreen(),
      ),
      GoRoute(
        path: '/createJournalScreen',
        name: PageUrl.createJournalScreen,
        builder: (context, state) => CreateJournalScreen(
          prompt: state.uri.queryParameters[PathParam.prompt] != null
              ? JournalPrompt.fromJson(
                  jsonDecode(state.uri.queryParameters[PathParam.prompt] ?? ''),
                )
              : null,
          journal: state.uri.queryParameters[PathParam.journal] != null
              ? GuidedJournal.fromJson(
                  jsonDecode(
                      state.uri.queryParameters[PathParam.journal] ?? ''),
                )
              : null,
        ),
      ),
      GoRoute(
        path: '/guidedJournalScreen',
        name: PageUrl.guidedJournalScreen,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: const JournalScreen()),
        // builder: (context, state) => const JournalScreen(),
      ),
      GoRoute(
        path: '/passwordResetSuccessScreen',
        name: PageUrl.passwordResetSuccessScreen,
        builder: (context, state) => const PasswordResetSuccessScreen(),
      ),
      GoRoute(
        path: '/notificationsScreen',
        name: PageUrl.notificationsScreen,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/streakDetailsScreen',
        name: PageUrl.streakDetailsScreen,
        builder: (context, state) => const StreakDetailsScreen(),
      ),
      GoRoute(
        path: '/badgesScreen',
        name: PageUrl.badgesScreen,
        builder: (context, state) => const BadgesScreen(),
      ),
      GoRoute(
        path: '/promptsCategoryScreen',
        name: PageUrl.promptsCategoryScreen,
        builder: (context, state) => const PromptsCategoryScreen(),
      ),
      GoRoute(
        path: '/guidedPromptScreen',
        name: PageUrl.guidedPromptScreen,
        builder: (context, state) => GuidedPromptsScreen(
          categoryId: state.uri.queryParameters[PathParam.id] ?? '',
        ),
      ),
      GoRoute(
          path: '/therapyCallScreen',
          name: PageUrl.therapyCallScreen,
          builder: (context, state) => TherapyCallScreen(
                callerId: int.parse(
                    state.uri.queryParameters[PathParam.callerId] ?? '0'),
                calleeId: int.parse(
                    state.uri.queryParameters[PathParam.calleeId] ?? '0'),
                offer: state.uri.queryParameters[PathParam.offer] != null
                    ? SdpOffer.fromJson(
                        jsonDecode(
                            state.uri.queryParameters[PathParam.offer] ?? ''),
                      )
                    : null,
                therapist: state.uri.queryParameters[PathParam.caller] != null
                    ? Caller.fromJson(
                        jsonDecode(
                            state.uri.queryParameters[PathParam.caller] ?? ''),
                      )
                    : null,
                sessionId: state.uri.queryParameters[PathParam.sessionId] ?? 0,
              )),
      GoRoute(
          path: '/questionaireScreen',
          name: PageUrl.questionaireScreen,
          builder: (context, state) => QuestionaireScreen(
                id: state.uri.queryParameters[PathParam.id] ?? '0',
                name: state.uri.queryParameters[PathParam.name] ?? ' ',
              )),
      GoRoute(
          path: '/worksheetDetails',
          name: PageUrl.worksheetDetails,
          builder: (context, state) => WorksheetDetailScreen(
                id: state.uri.queryParameters[PathParam.id] ?? '0',
                name: state.uri.queryParameters[PathParam.name] ?? ' ',
              )),
    ],
  );

  static CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
