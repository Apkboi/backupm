import 'package:mentra/core/di/injector.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

class MesiboService {
  static final MesiboService _instance = MesiboService._internal();

  factory MesiboService() => _instance;

  //
  MesiboService._internal() {
    // Initialize Mesibo SDK with your app details
    Mesibo _mesibo = Mesibo();
  }

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

      Mesibo mesibo = Mesibo();

      await mesibo.setAccessToken(token);
      mesibo.setListener(listener);
      mesibo.start();
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

  Future<void> groupCall(String appName) async {
    // Handle incoming Mesibo events
    MesiboUI _mesiboUi = MesiboUI();

    _mesiboUi.getUiDefaults().then((MesiboUIOptions options) async {
      options.enableBackButton = true;
      options.appName = appName;
      options.toolbarColor = 0xff00868b;
      _mesiboUi.setUiDefaults(options);
    });

    MesiboUIButtons buttons = MesiboUIButtons();
    buttons.message = true;
    buttons.audioCall = false;
    buttons.videoCall = true;
    buttons.groupAudioCall = true;
    buttons.groupVideoCall = true;
    buttons.endToEndEncryptionInfo = false; // e2ee should be enabled
    _mesiboUi.setupBasicCustomization(buttons, null);

    await Future.delayed(Duration(milliseconds: 500));

    MesiboProfile profile =
        MesiboProfile(groupId: 2988983, uid: 6361887, selfProfile: false);

    _mesiboUi.groupCall(profile, true, true, false, false);
  }
}
