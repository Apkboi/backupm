import 'package:flutter/services.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

class MyMesibo extends MesiboFlutter {
  static MyMesibo? _instance = null;
  static MesiboInternal? _internalInstance = null;
  static MesiboEndToEndEncryption? _e2ee = null;
  static MesiboPhoneContactsManager? _phoneContactManager = null;
  static const int MESIBO_STATUS_UNKNOWN = 0;
  static const int MESIBO_STATUS_ONLINE = 1;
  static const int MESIBO_STATUS_OFFLINE = 2;
  static const int MESIBO_STATUS_SIGNOUT = 3;
  static const int MESIBO_STATUS_AUTHFAIL = 4;
  static const int MESIBO_STATUS_STOPPED = 5;
  static const int MESIBO_STATUS_CONNECTING = 6;
  static const int MESIBO_STATUS_CONNECTFAILURE = 7;
  static const int MESIBO_STATUS_NONETWORK = 8;
  static const int MESIBO_STATUS_ONPREMISEERROR = 9;
  static const int MESIBO_STATUS_SUSPEND = 10;
  static const int MESIBO_STATUS_UPDATE = 20;
  static const int MESIBO_STATUS_MANDUPDATE = 21;
  static const int MESIBO_STATUS_SHUTDOWN = 22;

  static const MessageCodec<Object?> codec = _MesiboFlutterCodec();

  factory MyMesibo() {
    if (_instance != null) {
      return _instance!;
    }
    _instance = MyMesibo._init();
    return _instance!;
  }

  static MyMesibo getInstance() {
    if (null == _instance) {
      _instance = MyMesibo();
    }
    return _instance!;
  }

  static MesiboInternal getInternal() {
    return _internalInstance!;
  }

  MyMesibo._init() : super() {
    _internalInstance = MesiboInternal();
    _e2ee = MesiboEndToEndEncryption();
    _phoneContactManager = MesiboPhoneContactsManager();
  }

  void setListener(Object listener) {
    _internalInstance?.mConnectionListeners.clear();
    _internalInstance?.mMessageListeners.clear();
    // _internalInstance?.setListener(listener);

    logger.i(_internalInstance?.mConnectionListeners.length);
  }

  @override
  Future<MesiboProfile> getProfile(String? arg_peer, int? arg_group) async {
    MesiboGroupProfile? profile =
        MesiboGroupProfile.getCachedProfile(arg_peer, arg_group, false);
    if (profile != null) return Future<MesiboProfile>.value(profile);
    profile =
        await super.getProfile(arg_peer!, arg_group!) as MesiboGroupProfile;
    return Future<MesiboProfile>.value(profile);
  }

  Future<MesiboProfile> getUserProfile(String peer) async {
    return getProfile(peer, 0);
  }

  Future<MesiboProfile> getGroupProfile(int groupId) async {
    return getProfile(null, groupId);
  }

  void createGroup(meSibofLuTtERcLass settings, MesiboGroupListener listener) {
    _internalInstance?.setCreateGroupListener(listener);
    _internalInstance?.createGroup(settings);
  }

  MesiboPhoneContactsManager getPhoneContactsManager() {
    return _phoneContactManager!;
  }

  MesiboEndToEndEncryption e2ee() {
    return _e2ee!;
  }
}

class _MesiboFlutterCodec extends StandardMessageCodec {
  const _MesiboFlutterCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is MesiboProfileFlutter) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return MesiboProfileFlutter.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
