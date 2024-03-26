import 'package:mentra/core/di/injector.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

class MyListenerClass
    implements
        MesiboConnectionListener,
        MesiboMessageListener,
        MesiboGroupListener {
  @override
  void Mesibo_onConnectionStatus(int status) {
    logger.i(status);
  }

  @override
  void Mesibo_onGroupCreated(MesiboProfile profile) {
    // TODO: implement Mesibo_onGroupCreated
  }

  @override
  void Mesibo_onGroupError(MesiboProfile profile, int error) {
    // TODO: implement Mesibo_onGroupError
  }

  @override
  void Mesibo_onGroupJoined(MesiboProfile profile) {
    // TODO: implement Mesibo_onGroupJoined
  }

  @override
  void Mesibo_onGroupLeft(MesiboProfile profile) {
    // TODO: implement Mesibo_onGroupLeft
  }

  @override
  void Mesibo_onGroupMembers(
      MesiboProfile profile, List<MesiboGroupMember?> members) {
    // TODO: implement Mesibo_onGroupMembers
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
    // TODO: implement Mesibo_onMessage
  }

  @override
  void Mesibo_onMessageStatus(MesiboMessage message) {
    // TODO: implement Mesibo_onMessageStatus
  }

  @override
  void Mesibo_onMessageUpdate(MesiboMessage message) {
    // TODO: implement Mesibo_onMessageUpdate
  }
}
