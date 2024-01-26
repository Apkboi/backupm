import 'package:get_it/get_it.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<RegistrationBloc>(
      () => RegistrationBloc(getIt.get()));
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(getIt.get()));
  getIt.registerLazySingleton<UserBloc>(() => UserBloc());
  getIt.registerLazySingleton<UserPreferenceCubit>(() => UserPreferenceCubit());
  getIt.registerLazySingleton<DashboardBloc>(() => DashboardBloc(injector.get()));
}
