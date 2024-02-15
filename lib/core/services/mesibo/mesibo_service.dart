import 'package:mentra/core/di/injector.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

class MesiboService {
  // static final MesiboService _instance = MesiboService._internal();
  //
  // factory MesiboService() => _instance;
  //
  // MesiboService._internal() {
  //   // Initialize Mesibo SDK with your app details
  // }

  Future<void> login(
      {required String token,
      required Object listener,
      required String appName}) async {
    // Mesibo login logic
    // optional - only to show alert in AUTHFAIL case

    try {

      Future<String> asyncAppId =
          injector.get<Mesibo>().getAppIdForAccessToken();
      asyncAppId.then((String appid) {
        logger.i(appid);
      });

      // initialize mesibo
      // injector.get<Mesibo>() = Mesibo();
      // injector.get<MesiboUI>() = MesiboUI();
      await injector.get<Mesibo>().setAccessToken(token);
      injector.get<Mesibo>().setListener(listener);
      await injector.get<Mesibo>().start();



      injector.get<MesiboUI>().getUiDefaults().then((MesiboUIOptions options) {
        options.enableBackButton = true;
        options.appName = appName;

        // options.toolbarColor = 0xff00868b;
        injector.get<MesiboUI>().setUiDefaults(options);
      });


      MesiboUIButtons buttons = MesiboUIButtons();
      buttons.message = true;
      buttons.audioCall = false;
      buttons.videoCall = true;
      buttons.groupAudioCall = true;
      buttons.groupVideoCall = true;
      buttons.endToEndEncryptionInfo = false; // e2ee should be enabled
      injector.get<MesiboUI>().setupBasicCustomization(buttons, null);
    } catch (e) {
      logger.e(e.toString());
      // TODO
    }

    // logger.i( injector.get<MesiboUI>().);
  }

  Future<void> startChat(String contactId) async {
    // Start chat conversation
  }

  Future<void> sendMessage(String contactId, String message) async {
    // Send message logic
  }

  void subscribeToEvents() {
    // Register for Mesibo events
  }

// void handleEvents(MesiboEvent event) {
//   // Handle incoming Mesibo events
// }
}
