
import 'package:get_it/get_it.dart';
import 'package:mentra/core/services/biometric/biometric_service.dart';
import 'package:mentra/core/services/biometric/local_auth_biometric_service.dart';
import 'package:mentra/core/services/location_service/location_service.dart';


void setup(GetIt getIt) {
  //
  // getIt.registerLazySingleton<NetworkService>(
  //         () => NetworkService(baseUrl: UrlConfig.coreBaseUrl));
  getIt.registerLazySingleton<LocationService>(() => LocationService());
  getIt.registerLazySingleton<BiometricService>(() => LocalAuthBiometricService());
}
