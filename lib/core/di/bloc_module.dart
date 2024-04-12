import 'package:get_it/get_it.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/local_auth/presentation/blocs/local_auth/local_auth_cubit.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/mentra_chat/mentra_chat_bloc.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/subscription/presentation/bloc/subscription_bloc/subscription_bloc.dart';
import 'package:mentra/features/tasks/presentation/bloc/daily_task_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<RegistrationBloc>(
      () => RegistrationBloc(getIt.get()));
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(getIt.get()));
  getIt.registerLazySingleton<UserBloc>(() => UserBloc(getIt.get()));
  getIt.registerLazySingleton<UserPreferenceCubit>(
      () => UserPreferenceCubit(injector.get()));
  getIt.registerLazySingleton<DashboardBloc>(
      () => DashboardBloc(injector.get()));
  getIt.registerLazySingleton<TherapyBloc>(() => TherapyBloc(injector.get()));
  getIt.registerLazySingleton<SubscriptionBloc>(
      () => SubscriptionBloc(injector.get()));
  getIt.registerLazySingleton<SettingsBloc>(() => SettingsBloc(injector.get()));
  getIt.registerLazySingleton<WellnessLibraryBloc>(
      () => WellnessLibraryBloc(injector.get()));
  getIt.registerLazySingleton<JournalBloc>(() => JournalBloc(injector.get()));
  getIt.registerLazySingleton<NotificationsBloc>(
      () => NotificationsBloc(injector.get()));
  getIt.registerLazySingleton<MentraChatBloc>(
      () => MentraChatBloc(injector.get()));
  getIt.registerLazySingleton<PasswordResetBloc>(
      () => PasswordResetBloc(injector.get()));
  getIt.registerLazySingleton<LocalAuthCubit>(() => LocalAuthCubit());
  getIt.registerLazySingleton<BotChatCubit>(() => BotChatCubit());
  getIt.registerLazySingleton<DailyTaskBloc>(
      () => DailyTaskBloc(injector.get()));

  // getIt.registerLazySingleton<MentraChatBloc>(
  //     () => MentraChatBloc(injector.get()));
}
