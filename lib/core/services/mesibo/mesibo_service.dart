import 'package:mentra/core/di/injector.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';
import 'package:uuid/uuid.dart';

class MesiboService {
  static final MesiboService _instance = MesiboService._internal();
  Mesibo mesibo = Mesibo();

  factory MesiboService() => _instance;

  //
  MesiboService._internal() {
    // Initialize Mesibo SDK with your app details
    // Mesibo _mesibo = Mesibo();
  }

  static Future<void> login(
      {required String token,
      required Object listener,
      required String appName}) async {
    // Mesibo login logic
    // optional - only to show alert in AUTHFAIL case

    try {
      Mesibo mesibo = Mesibo();
      // await mesibo.stop();
      Future<String> asyncAppId = mesibo.getAppIdForAccessToken();
      asyncAppId.then((String appid) {
        logger.i(appid);
      });
      mesibo.setAccessToken(token);
      // mesibo.setListener(listener);
      // mesibo.start().then((value) => logger.i('MESIBO IS RUNNING'));
    } catch (e) {
      logger.e(e.toString());
      // TODO
    }
  }

  Future<void> startChat(String contactId) async {}

  Future<void> sendMessage(String contactId, String message) async {
    // Send message logic
  }

  Future<void> stop() async {
    await Mesibo.getInstance().stop();
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

    await Future.delayed(const Duration(milliseconds: 500));
    MesiboProfile profile = MesiboProfile(
        groupId: 2988983,
        uid: 6361887,
        selfProfile: false,
        hash_id: int.parse(const Uuid().v1()));
    _mesiboUi.groupCall(profile, true, true, false, false);
  }
}
