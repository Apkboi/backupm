import 'package:get_it/get_it.dart';
import 'package:mentra/features/mesibo/presentation/bloc/mesibo_cubit.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

void setup(GetIt getIt) {
  getIt.registerLazySingleton<Mesibo>(
          () => Mesibo());
  getIt.registerLazySingleton<MesiboUI>(() => MesiboUI());
  getIt.registerLazySingleton<MesiboCubit>(() => MesiboCubit());
}



