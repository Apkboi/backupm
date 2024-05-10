import 'package:flutter_background/flutter_background.dart';
import 'package:mentra/app_config.dart';
import 'package:mentra/core/services/network/url_config.dart';

Future<void> main() async {
  FlutterBackgroundAndroidConfig androidConfig =
      const FlutterBackgroundAndroidConfig(
    notificationTitle: "Mentra",
    notificationText: "Mentra is running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon:
        AndroidResource(name: 'background_icon', defType: 'drawable'),
  );

AppConfig.initializeAndRunInstance(
      appName: 'Mentra', enviroment: Environment.development);
      
  bool initialized =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  bool enabled = await FlutterBackground.enableBackgroundExecution();

  print("Background check");
  print(initialized);
  print(enabled);

  
}
