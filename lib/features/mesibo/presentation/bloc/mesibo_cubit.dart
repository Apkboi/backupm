import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/mesibo/mesibo_service.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

part 'mesibo_state.dart';

class MesiboCubit extends Cubit<MesiboState>
    implements
        MesiboConnectionListener,
        MesiboMessageListener,
        MesiboGroupListener {
  bool authFail = false;

  MesiboCubit() : super(MesiboInitial());

  final MesiboService _mesiboService = MesiboService();
  bool mOnline = false;

  // final Mesibo _mesibo = Mesibo();

  Future<void> startGroupCall() async {
    // await _mesiboService.groupCall('Mentra');
    await _mesiboService.groupCall('Mentra');
  }

  Future<void> stop() async {
    // await _mesiboService.groupCall('Mentra');
    await _mesiboService.stop();
  }

  Future<void> initialize() async {
    try {
      await _mesiboService.login(
          token:
              "68a28b89c8000016ebbd246fc64ccdd92444cf4557d0e444ac8d2iabc21eeb520",
          listener: this,
          appName: "Mentra");

      // await _mesibo.setAccessToken('68a28b89c8000016ebbd246fc64ccdd92444cf4557d0e444ac8d2iabc21eeb520');
      // _mesibo.setListener(this);
      // await _mesibo.start();
    } catch (e) {
      // handleError(e.message);
    }
  }

  // OVERRIDEN METHODS

  @override
  void Mesibo_onConnectionStatus(int status) {
    logger.i('Mesibo_onConnectionStatus: $status');

    if (authFail) return; // to prevent overwriting displayed status
    String statusText = status.toString();
    if (status == Mesibo.MESIBO_STATUS_ONLINE) {
      statusText = "Online";
    } else if (status == Mesibo.MESIBO_STATUS_CONNECTING) {
      statusText = "Connecting";
    } else if (status == Mesibo.MESIBO_STATUS_CONNECTFAILURE) {
      statusText = "Connect Failed";
    } else if (status == Mesibo.MESIBO_STATUS_NONETWORK) {
      statusText = "No Network";
    } else if (status == Mesibo.MESIBO_STATUS_AUTHFAIL) {
      authFail = true;
      String warning =
          "The token is invalid. Ensure that you have used appid \"" +
              "\" to generate Mesibo user access token";
      statusText = warning;
      logger.e(warning);
      // showAlert("Auth Fail", warning);
    }

    // _mesiboStatus = 'Mesibo status: ' + statusText;
    // setState(() {});

    if (1 == status) mOnline = true;
  }

  @override
  void Mesibo_onGroupCreated(MesiboProfile profile) {
    logger.i('Mesibo_onGroupCreated: $profile');
  }

  @override
  void Mesibo_onGroupError(MesiboProfile profile, int error) {
    logger.i('Mesibo_onGroupError: $error');
  }

  @override
  void Mesibo_onGroupJoined(MesiboProfile profile) {
    logger.i('Mesibo_onGroupJoined: $profile');
  }

  @override
  void Mesibo_onGroupLeft(MesiboProfile profile) {
    // TODO: implement Mesibo_onGroupLeft
  }

  @override
  void Mesibo_onGroupMembers(
      MesiboProfile profile, List<MesiboGroupMember?> members) {
    logger.i('Mesibo_onGroupMembers: $profile');
    //
  }

  @override
  void Mesibo_onGroupMembersJoined(
      MesiboProfile profile, List<MesiboGroupMember?> members) {
    // TODO: implement Mesibo_onGroupMembersJoined
  }

  @override
  void Mesibo_onGroupMembersRemoved(
      MesiboProfile profile, List<MesiboGroupMember?> members) {
    // TODO: implement Mesibo_onGroupMembersRemoved
  }

  @override
  void Mesibo_onGroupSettings(
      MesiboProfile profile,
      MesiboGroupSettings? groupSettings,
      MesiboMemberPermissions? memberPermissions,
      List<MesiboGroupPin?> groupPins) {
    // TODO: implement Mesibo_onGroupSettings
  }

  @override
  void Mesibo_onMessage(MesiboMessage message) {
    logger.i('Mesibo_onMessage: $message');
  }

  @override
  void Mesibo_onMessageStatus(MesiboMessage message) {
    // TODO: implement Mesibo_onMessageStatus
  }

  @override
  void Mesibo_onMessageUpdate(MesiboMessage message) {
    // TODO: implement Mesibo_onMessageUpdate
  }

// @override
// void Mesibo_onGroupLeft(MesiboProfile profile) {
//   // TODO: implement Mesibo_onGroupLeft
// }
}
