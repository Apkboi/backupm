import 'package:get_it/get_it.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/subscription/presentation/bloc/subscription_bloc/subscription_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';

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
}
