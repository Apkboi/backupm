import 'package:get_it/get_it.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<RegistrationBloc>(
      () => RegistrationBloc(getIt.get()));
  getIt.registerLazySingleton<LoginBloc>(() => LoginBloc(getIt.get()));
  getIt.registerLazySingleton<UserBloc>(() => UserBloc());
}
