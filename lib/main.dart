import 'package:mentra/app_config.dart';
import 'package:mentra/core/services/network/url_config.dart';


void main() {
  AppConfig.initializeAndRunInstance(
      appName: 'Mentra', enviroment: Environment.development);
}
