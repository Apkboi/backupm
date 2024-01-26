enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');
  static const String dojahTestAppId = String.fromEnvironment('DOJAH_APP_ID');
  static const String dojahTestPublicKey =
      String.fromEnvironment('DOJAH_PUBLIC_KEY');
  static const String facePlusTestApiKey =
      String.fromEnvironment('FACE_PLUS_TEST_API_KEY');
  static const String facePlusTestApiSecret =
      String.fromEnvironment('FACE_PLUS_TEST_API_SECRET');
  static const String messageUserEmail =
      String.fromEnvironment('MESSAGE_USER_EMAIL');
  static const String messageUserPassKey =
      String.fromEnvironment('MESSAGE_USER_PASSKEY');

  // static const String facePlusProdApiKey =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_KEY');
  // static const String facePlusProdApiSecret =
  //     String.fromEnvironment('FACE_PLUS_PROD_API_SECRET');
  static final coreBaseUrl =
      environment == Environment.production ? PRODUCTION_URL : STAGING_URL;

  static const String login = '/auth/login';
  static const String me = '/auth/me';

  static const String loginPreview = "/auth/login/preview";

  static const String getLibraryCoursesEndpoint = "/wellness-library/courses/list";

  static const String getLibraryCategoriesEndpoint = "/wellness-library/categories/list";

  static const String getConversationStarterEndpoint = "/user/conversation-starter/get";

  static String getUser(String userId) => '/auth/user/$userId';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/otp/verify';
  static const String register = '/auth/register';
  static const String oauthLogin = '/auth/oauth-login';
  static const String sendOtp = '/auth/register/steps';

  ///CONFIGS
  ///
  static const String getConfigs = '/general/configs';
  static const String getCountries = '/location/countries?per_page=300';

  ///WASTE DISPOSAL
  static const String initializeWasteDisposal = '/waste-management/create';
  static const String getAllRequests = '/waste-management/view-all';
  static const String acceptInvoice = '/waste-management/view-all';
  static const String uploadManifest = '/waste-management/view-all';

  static String viewSingleRequest(String requestId) =>
      '/waste-management/single/$requestId';

  ///ACCOUNT
  static const String updateProfile = '/account/update';
  static const String changePassword = '/account/change-password';
  static const String updatePassword = '/general/account/change-password';
  static const String allowNotifications = 'general/account/allow-notification';

  static const String deleteAccount = 'general/account/deactivate';
  static const String updateOnlineStatus = '/user/update_if_online';
  static const String resetPassword = '/auth/reset-password';

/// Therapy
  static const String upcomingSessions = '/user/session/schedule/upcoming';
  static const String sessionHistory = '/user/session/schedule/history';
  static const String sessionTimeSlots = '/user/session/schedule/fetch-timeslots';
  static const String createSession = '/user/session/schedule/create';
  static const String fetchDates = '/user/session/schedule/fetch-dates';
  static const String cancelSession = '/user/session/schedule/cancel';
  static const String rescheduleSession = '/user/session/schedule/reschedule';
  static const String matchTherapist = '/user/session/therapist/match';
  static const String selectTherapist = '/user/session/therapist/select';

//  NOtification
  static const String getNotifications = '/notifications/list';
}
