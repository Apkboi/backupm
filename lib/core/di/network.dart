import 'package:get_it/get_it.dart';
import 'package:mentra/core/services/network/network_service.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
}
