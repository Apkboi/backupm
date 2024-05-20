enum Environment { development, staging, qa, production }

class UrlConfig {
  static Environment environment = Environment.staging;

  static const String STAGING_URL = String.fromEnvironment('DEV_BASE_URL');
  static const String PRODUCTION_URL = String.fromEnvironment('PROD_BASE_URL');

  static const String imageBaseUrl = String.fromEnvironment('IMAGE_BASE_URL');
  static const String dojahTestAppId = String.fromEnvironment('DOJAH_APP_ID');
  static const String dojahTestPublicKey =
      String.fromEnvironment('DOJAH_PUBLIC_KEY');
  static const String stripeTestKey = String.fromEnvironment('STRIPE_TEST_KEY');
  static const String stripeSecretKey =
      String.fromEnvironment('STRIPE_SECRET_KEY');
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

  static const String getLibraryCoursesEndpoint =
      "/wellness-library/courses/list";

  static const String getNotificationDetailsEndpoint =
      "/getNotificationDetailsEndpoint";

  static const String clearNotifications = "/notifications/clear-all";

  static String readNotificationEndpoint(String id) =>
      "/notifications/$id/show";

  static String getNotificationsEndpoint = '/notifications/list';

  static String deleteAccountEndpoint = '/user/profile/delete-account';

  static String eraseDataEndpoint = '/user/profile/erase-account-data';

  static String getCourseDetails(String id) =>
      "/wellness-library/courses/show/$id";
  static const String getFavourites = "/wellness-library/courses/favourites";
  static const String updateFavourite =
      "/wellness-library/courses/save-to-favourite";
  static const String getLibraryCategoriesEndpoint =
      "/wellness-library/categories/list";
  static const String getConversationStarterEndpoint =
      "/user/conversation-starter/get";

  //SOS
  static const String getEmergencyContacts = '/emergency-contacts/list';

  // Authentication
  static const String login = '/auth/login';
  static const String me = '/auth/me';
  static const String loginPreview = "/auth/login/preview";

  static String getUser(String userId) => '/auth/user/$userId';
  static const String verifyOtp = '/auth/otp/verify';
  static const String register = '/auth/register';
  static const String oauthLogin = '/auth/oauth-login';
  static const String sendOtp = '/auth/register/steps';
  static const String forgotPassword = '/auth/password/forgot';
  static const String passwordReset = '/auth/password/reset';

  ///ACCOUNT
  static const String updateProfile = '/user/profile/update';
  static const String changePassword = '/user/passcode/change-password';
  static const String verifyPasscode = '/user/passcode/verify';
  static const String updatePassword = '/user/passcode/update';
  static const String allowNotifications = 'general/account/allow-notification';
  static const String resetPassword = '/auth/password/reset';
  static const String getAvatars = '/profile/avatars';
  static const String uploadAvatar = '/user/profile/upload-avatar';
  static const String getProfile = '/user/me';

  /// Therapy
  static const String upcomingSessions = '/user/session/schedule/upcoming';
  static const String sessionHistory = '/user/session/schedule/history';

  static const String sessionTimeSlots = '/availability/get-availability';

  // static const String sessionTimeSlots =
  //     '/user/session/schedule/fetch-timeslots';
  static const String createSession = '/user/session/schedule/create';
  static const String updatePreference = '/user/therapy/preferences';
  static const String fetchDates = '/user/session/schedule/fetch-dates';
  static const String cancelSession = '/user/session/schedule/cancel';
  static const String rescheduleSession = '/user/session/schedule/reschedule';
  static const String matchTherapist = '/user/session/therapist/match';
  static const String selectTherapist = '/user/session/therapist/select';
  static const String getMatchedTherapist = '/user/session/therapist/select';
  static const String createReview = '/user/session/reviews/create';
  static const String reviewAiSession = '/user/ai-sessions/send-review';
  static const String getReviews = '/user/session/reviews/list';
  static const String sessionFocus = '/user/session/focus/list';
  static const String report = '/user/report/save';

//  NOtification
  static const String getNotifications = '/notifications/list';

  //  Subscription
  static const String getPlans = '/finance/plans';
  static const String subscribe = '/finance/subscriptions/initiate';
  static const String getPaymentIntent = '/finance/subscriptions/initiate';
  static  String   cancelSubscription(String id) => '/finance/subscriptions/$id/cancel';

  //  Journals
  static String getPrompts(String id) => '/guided-prompts-categories/$id/show';
  static const String getJournals = '/guided-journals';
  static const String saveJournals = '/guided-journals/save';

  static String deleteJournal(String id) => '/guided-journals/$id/delete';

  static String updateJournal(String id) => '/guided-journals/$id/update';
  static String getPromptsCategory = '/guided-prompts-categories';

//   Mentra chat
  static const String currentSession = '/user/ai-sessions/current';
  static const String continueSession = '/user/ai-sessions/send-message';
  static const String populateChat = '/user/ai-sessions/populate';

  static String endSession = '/user/ai-sessions/end';

//   MOOD CHECKER
  static String updateMoodChecker = '/user/mood-checker/save';

  //   MOOD CHECKER
  static String getDailyTasks = '/daily-tasks/list';
  static String getStreaks = '/badges/list';
  static String updateDailyTasks = '/daily-tasks/save';

//   CALL ENDPOINTS
  static String callAction = '/webrtc/call-action';
  static String iceCandidate = '/webrtc/ice-candidate';
  static String endCall = '/webrtc/end-call';
  static String answerCall = '/webrtc/answer-call';
  static String makeCall = '/webrtc/make-call';

  static String getOffer(callerId) => '/webrtc/get-offer/$callerId';

//   Chat Endpoint
  static String sendMessage = "/messages/send-message";
  static String getConversations = "/messages/get-conversations";
  static String getMessages = "/messages/get-matched-messages";

  static String deleteMessage(int messageId) =>
      "/messages/delete-message/$messageId";

  static String deleteConversation(int conversationId) =>
      "/messages/delete-conversation/$conversationId";

//   WorkSheet
  static String getWorkSheets= "/work-sheet";
  static String getQuestionaires= "/getQuestionaires";
  static String submitQuestionaires = "/submitQuestionaires";
  static String markTask= "/markTask ";
}
