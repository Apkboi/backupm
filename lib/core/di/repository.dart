import 'package:get_it/get_it.dart';
import 'package:mentra/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mentra/features/authentication/dormain/repository/auth_repository.dart';
import 'package:mentra/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:mentra/features/dashboard/dormain/repository/dashboard_repository.dart';
import 'package:mentra/features/library/data/repository/wellness_library_repository_impl.dart';
import 'package:mentra/features/library/dormain/repository/wellness_library_repository.dart';
import 'package:mentra/features/therapy/presentation/data/repository/therapy_repository_impl.dart';
import 'package:mentra/features/therapy/presentation/dormain/repository/therapy_repository.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<WellnessLibraryRepository>(
      () => WellnessLibraryRepositoryImpl(getIt.get()));
  getIt.registerLazySingleton<TherapyRepository>(
      () => TherapyRepositoryImpl(getIt.get()));
}
