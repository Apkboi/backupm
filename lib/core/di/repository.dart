import 'package:get_it/get_it.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';


void setup(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt.get()));
}
