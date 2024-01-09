import 'package:logger/logger.dart';
import 'package:mentra/core/di/bloc_module.dart' as blocModule;
import 'package:mentra/core/di/network.dart' as networkModule;

import 'package:mentra/core/di/repository.dart' as repositoryModule;
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;
final logger = Logger();
Future<void> init() async{
  networkModule.setup(injector);
  repositoryModule.setup(injector);
  blocModule.setup(injector);
}
