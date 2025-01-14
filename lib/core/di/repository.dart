import 'package:get_it/get_it.dart';
import 'package:mentra/features/account/data/repository/account_repository_impl.dart';
import 'package:mentra/features/account/dormain/repository/account_repository.dart';
import 'package:mentra/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:mentra/features/authentication/password_reset/data/repository/password_reset_repository_impl.dart';
import 'package:mentra/features/authentication/password_reset/dormain/repository/password_reset_repository.dart';
import 'package:mentra/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:mentra/features/dashboard/dormain/repository/dashboard_repository.dart';
import 'package:mentra/features/journal/data/repository/journals_repository_impl.dart';
import 'package:mentra/features/journal/dormain/repository/journals_repository.dart';
import 'package:mentra/features/library/data/repository/wellness_library_repository_impl.dart';
import 'package:mentra/features/library/dormain/repository/wellness_library_repository.dart';
import 'package:mentra/features/mentra_bot/data/repository/mentra_chat_repository_impl.dart';
import 'package:mentra/features/mentra_bot/dormain/repository/mentra_chat_repository.dart';
import 'package:mentra/features/notification/presentation/data/repository/notifications_repository_impl.dart';
import 'package:mentra/features/notification/presentation/dormain/repository/notifications_repository.dart';
import 'package:mentra/features/settings/data/repository/settings_repository_impl.dart';
import 'package:mentra/features/settings/data/repository/user_preference_rpository_impl.dart';
import 'package:mentra/features/settings/dormain/repository/settings_repository.dart';
import 'package:mentra/features/settings/dormain/repository/user_preference_rpository.dart';
import 'package:mentra/features/streaks/data/repository/streaks_repository_impl.dart';
import 'package:mentra/features/streaks/domain/repository/steaks_repository.dart';
import 'package:mentra/features/subscription/data/repository/subscription_repository_impl.dart';
import 'package:mentra/features/subscription/dormain/repository/subscription_repository.dart';
import 'package:mentra/features/tasks/data/repository/daily_task_repository_impl.dart';
import 'package:mentra/features/tasks/domain/repository/daily_task_repository.dart';
import 'package:mentra/features/therapy/data/repository/call_repository_impl.dart';
import 'package:mentra/features/therapy/data/repository/session_chat_repository.dart';
import 'package:mentra/features/therapy/data/repository/therapy_repository_impl.dart';
import 'package:mentra/features/therapy/dormain/repository/call_repository.dart';
import 'package:mentra/features/therapy/dormain/repository/session_chat_repository.dart';
import 'package:mentra/features/therapy/dormain/repository/therapy_repository.dart';
import 'package:mentra/features/work_sheet/data/repositories/work_sheet_repository.dart';
import 'package:mentra/features/work_sheet/dormain/repositories/work_sheey_repository.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<WellnessLibraryRepository>(
      () => WellnessLibraryRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<TherapyRepository>(
      () => TherapyRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<UserPreferenceRepository>(
      () => UserPreferenceRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<PasswordResetRepository>(
      () => PasswordResetRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<JournalsRepository>(
      () => JournalsRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<NotificationsRepository>(
      () => NotificationRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<MentraChatRepository>(
      () => MentraChatRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<DailyTaskRepository>(
      () => DailyTaskRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<StreaksRepository>(
      () => StreaksRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<CallRepository>(
      () => CallRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<SessionChatRepository>(
      () => SessionChatRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<WorkSheetRepository>(
      () => WorkSheetRepositoryImpl(getIt.get()));
}
