import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/mesibo/mesibo_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mesibo/presentation/bloc/mesibo_cubit.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';

class DemoUser {
  String token = "";
  String address = "";

  DemoUser(String t, String a) {
    token = t;
    address = a;
  }
}
// class SessionButton extends StatefulWidget {
//   final DateTime startDate;
//   final DateTime endDate;
//
//   const SessionButton(
//       {Key? key, required this.startDate, required this.endDate})
//       : super(key: key);
//
//   @override
//   _SessionButtonState createState() => _SessionButtonState();
// }
//
// class _SessionButtonState extends State<SessionButton> {
//   bool _showButton = false;
//   final bloc = MesiboCubit();
//
//   @override
//   void initState() {
//     super.initState();
//     _checkButtonVisibility();
//     // Update button visibility every second to reflect real-time
//     Timer.periodic(const Duration(seconds: 1), (_) => _checkButtonVisibility());
//   }
//
//   void _checkButtonVisibility() {
//     final now = DateTime.now();
//     setState(() {
//       _showButton = true;
//       // _showButton = widget.startDate.isBefore(now) && now.isBefore(widget.endDate);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _showButton
//         ? CustomNeumorphicButton(
//             expanded: false,
//             text: 'Join session',
//             padding: const EdgeInsets.all(10),
//             onTap: () async {
//               // await bloc.initialize();
//               _groupCall();
//             },
//             color: Pallets.primary)
//         : const SizedBox();
//   }
// }
//
// void _groupCall() async {
//   // if (!injector.get<MesiboCubit>().mOnline) return;
//
//   // MesiboProfile profile = await injector.get<Mesibo>().getGroupProfile( 2988820);
//   try {
//     MesiboProfile profile =
//         MesiboProfile(groupId: 2988983, uid: 6361887, selfProfile: false);
//     // logger.i(profile.getGroupProfile()?.status);
//     // await injector.get<MesiboUI>().launchMessaging(profile);
//
//     // await PermissionHandlerService().requestPermission(Permission.camera);
//     // await PermissionHandlerService().requestPermission(Permission.audio);
//     // await PermissionHandlerService().requestPermission(Permission.phone);
//     // await PermissionHandlerService().requestPermission(Permission.contacts);
//
//     // var userP = await injector.get<Mesibo>().getUserProfile('xyz@example.com');
//
//     // await injector.get<MesiboUI>().call(userP, false);
//
//     await injector.get<MesiboUI>().groupCall(profile, true, true, true, true);
//   }  catch (e) {
//     logger.e(e.toString());
//     // TODO
//   }
//
//   // logger.e(e.toString());
//   // logger.e(stack.toString());
//   //
// }

/// Widget to display start video call layout.
class SessionButton extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  SessionButton({required this.startDate, required this.endDate});

  @override
  _SessionButtonState createState() => _SessionButtonState();
}

class _SessionButtonState extends State<SessionButton>
    implements
        MesiboConnectionListener,
        MesiboMessageListener,
        MesiboGroupListener {
  void _checkButtonVisibility() {
    final now = DateTime.now();
    setState(() {
      _showButton = true;
      // _showButton = widget.startDate.isBefore(now) && now.isBefore(widget.endDate);
    });
  }

  static Mesibo _mesibo = Mesibo();
  static MesiboUI _mesiboUi = MesiboUI();
  String _mesiboStatus = 'Mesibo status: Not Connected.';
  Text? mStatusText;
  bool authFail = false;
  String mAppId = "";
  bool _showButton = false;

  /**********************************
      Please refer to the tutorial link below for details on obtaining user authentication tokens.

      https://docs.mesibo.com/tutorials/get-started/
   **********************************/
  DemoUser user1 = DemoUser(
      "168a28b89c8000016ebbd246fc64ccdd92444cf4557d0e444ac8d2iabc21eeb520",
      'vic@gmail.com');
  DemoUser user2 = DemoUser(
      "fcb17700353e8081dc836572521540a5f4927bb92145b441f3afe554ac422gadc2e18ac58",
      'xyz@example.com');

  String remoteUser = "";
  bool mOnline = false, mLoginDone = false;
  ElevatedButton? loginButton1, loginButton2;

  @override
  void initState() {
    super.initState();

    _checkButtonVisibility();
    // Update button visibility every second to reflect real-time
    Timer.periodic(const Duration(seconds: 1), (_) => _checkButtonVisibility());
  }

  @override
  void Mesibo_onConnectionStatus(int status) {
    print('Mesibo_onConnectionStatus: ' + status.toString());

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
              mAppId +
              "\" to generate Mesibo user access token";
      statusText = warning;
      print(warning);
      showAlert("Auth Fail", warning);
    }

    _mesiboStatus = 'Mesibo status: ' + statusText;
    setState(() {});

    if (1 == status) mOnline = true;
  }

  @override
  Widget build(BuildContext context) {
    return _showButton
        ? CustomNeumorphicButton(
            expanded: false,
            text: 'Join session',
            padding: const EdgeInsets.all(10),
            onTap: () async {
              await injector.get<MesiboCubit>().startGroupCall();
              // await bloc.initialize();
              // initMesibo(user1.token);
              MesiboService service = MesiboService();

              service.groupCall('Mentra');

              // _groupCall();
            },
            color: Pallets.primary)
        : const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showAlert(String title, String body) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(body),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool isOnline() {
    if (mOnline) return true;
    showAlert("Not Online", "First login with a valid token");
    return false;
  }

  void initMesibo(String token) async {
    // optional - only to show alert in AUTHFAIL case

    Future<String> asyncAppId = _mesibo.getAppIdForAccessToken();
    asyncAppId.then((String appid) {
      mAppId = appid;
    });

    // initialize mesibo
    _mesibo.setAccessToken(token);
    _mesibo.setListener(this);
    _mesibo.start();

    /**********************************
        override default UI text, colors, etc.Refer to the documentation

        https://docs.mesibo.com/ui-modules/

        Also refer to the header file for complete list of parameters (applies to both Android/iOS)
        https://github.com/mesibo/mesiboframeworks/blob/main/mesiboui.framework/Headers/MesiboUI.h#L170
     **********************************/

    _mesiboUi.getUiDefaults().then((MesiboUIOptions options) {
      options.enableBackButton = true;
      options.appName = "My First App";
      options.toolbarColor = 0xff00868b;
      _mesiboUi.setUiDefaults(options);
    });

    /**********************************
        The code below enables basic UI customization.

        However, you can customize entire user interface by implementing MesiboUIListner for Android and
        iOS. Refer to

        https://docs.mesibo.com/ui-modules/customizing/
     **********************************/

    MesiboUIButtons buttons = MesiboUIButtons();
    buttons.message = true;
    buttons.audioCall = true;
    buttons.videoCall = true;
    buttons.groupAudioCall = true;
    buttons.groupVideoCall = true;
    buttons.endToEndEncryptionInfo = false; // e2ee should be enabled
    _mesiboUi.setupBasicCustomization(buttons, null);
  }

  void _loginUser1() {
    if (null == _mesibo) {
      showAlert("Mesibo NULL", "mesibo null");
      return;
    }
    if (mLoginDone) {
      showAlert("Failed",
          "You have already initiated login. If the connection status is not 1, check the token and the package name/bundle ID");
      return;
    }
    mLoginDone = true;
    initMesibo(user1.token);

    remoteUser = user2.address;
  }

  void _loginUser2() {
    if (mLoginDone) {
      showAlert("Failed",
          "You have already initiated login. If the connection status is not 1, check the token and the package name/bundle ID");
      return;
    }
    mLoginDone = true;
    initMesibo(user2.token);
    remoteUser = user1.address;
  }

  void _setProfileInfo() async {
    if (!isOnline()) return;
    MesiboProfile profile = await _mesibo.getSelfProfile() as MesiboProfile;

    profile.name = "Joe";
    profile.setImageUrl(
        "https://images.freeimages.com/images/large-previews/bbb/autumn-in-new-york-5-1360120.jpg");
    profile.save();
  }

  void _sendMessage() async {
    if (!isOnline()) return;
    MesiboProfile profile =
        await _mesibo.getUserProfile(remoteUser) as MesiboProfile;

    MesiboMessage m = profile.newMessage();
    m.message = "Hello from Flutter";
    m.send();
  }

  void _showMessages() async {
    if (!isOnline()) return;
    MesiboProfile profile =
        await _mesibo.getUserProfile(remoteUser) as MesiboProfile;

    _mesiboUi.launchMessaging(profile);
  }

  void _showUserList() {
    if (!isOnline()) return;
    _mesiboUi.launchUserList();
  }

  void _readSummary() async {
    if (!isOnline()) return;
    MesiboReadSession rs = MesiboReadSession.createReadSummarySession(this);
    rs.read(100);
  }

  void _readMessages() async {
    if (!isOnline()) return;
    MesiboProfile profile =
        await _mesibo.getUserProfile(remoteUser) as MesiboProfile;

    MesiboReadSession rs = profile.createReadSession(this);

    rs.read(100);
  }

  void _audioCall() async {
    if (!isOnline()) return;
    MesiboProfile profile =
        await _mesibo.getUserProfile(remoteUser) as MesiboProfile;
    _mesiboUi.call(profile, false);
  }

  void _videoCall() async {
    if (!isOnline()) return;
    MesiboProfile profile =
        await _mesibo.getUserProfile(remoteUser) as MesiboProfile;

    _mesiboUi.call(profile, true);
  }

  void _groupCall() async {
    // if (!isOnline()) return;
    int groupid =
        0; // create group first, add memmbers and then execute the following.

    // // disabled by defaut
    // if (0 == groupid) {
    //   showAlert("No group defined",
    //       "Refer to the group management documentation to create a group and add members before using group call function");
    //   return;
    // }

    MesiboProfile profile =
        MesiboProfile(groupId: 2988983, uid: 6361887, selfProfile: false);

    _mesiboUi.groupCall(profile, true, true, false, false);
  }

  void _syncPhoneContacts() async {
    _mesibo.getPhoneContactsManager().start();
  }

  void _getPhoneContacts() async {
    MesiboPhoneContact contact = (await _mesibo
        .getPhoneContactsManager()
        .getPhoneNumberInfo("+18005551234", null, true))! as MesiboPhoneContact;

    print(
        "Mesibo Contact: name ${contact.name} phone ${contact.phoneNumber} formatted ${contact.formattedPhoneNumber} country ${contact.country}");
  }

  void __createGroup() async {
    MesiboGroupSettings settings = MesiboGroupSettings();
    settings.name = "My Group";
  }

  @override
  void Mesibo_onMessage(MesiboMessage message) {
    String groupName = "";
    if (null != message.groupProfile) groupName = message.groupProfile!.name!;

    print('Mesibo_onMessage: from: (' +
        message.profile!.address! +
        ") group: (" +
        groupName +
        ") Message: " +
        message.message!);
    print('Mesibo_onMessage: date: (' +
        message.getTimestamp().getDate() +
        ') time: (' +
        message.getTimestamp().getTime() +
        ')');
  }

  @override
  void Mesibo_onMessageStatus(MesiboMessage message) {
    print('Mesibo_onMessageStatus: ' + message.status.toString());
  }

  @override
  void Mesibo_onMessageUpdate(MesiboMessage message) {
    print('Mesibo_onMessageUpdate: ' + message.message!);
  }

  @override
  void Mesibo_onGroupCreated(MesiboProfile profile) {}

  @override
  void Mesibo_onGroupJoined(MesiboProfile profile) {
    print("Mesibo Group Joined: " +
        profile.name! +
        " group id: " +
        profile.groupId.toString());
    MesiboMessage m = profile.newMessage();
    m.message = "Hey, I have joined this group from Flutter";
    m.send();

    MesiboGroupProfile? groupProfile = profile.getGroupProfile();
    if (groupProfile == null) return;
    groupProfile.getMembers(10, false, this);
  }

  @override
  void Mesibo_onGroupLeft(MesiboProfile profile) {
    print("Mesibo Group left: " +
        profile.name! +
        " group id: " +
        profile.groupId.toString());
  }

  @override
  void Mesibo_onGroupMembers(
      MesiboProfile profile, List<MesiboGroupMember?> members) {
    print("Mesibo Group members: " +
        profile.name! +
        " group id: " +
        profile.groupId.toString());

    for (final m in members) {
      String? name = m?.getProfile()!.getNameOrAddress();
      print("Mesibo group member: " + name!);
    }
  }

  @override
  void Mesibo_onGroupMembersJoined(
      MesiboProfile profile, List<MesiboGroupMember?> members) {
    print("Mesibo Group members joined: " +
        profile.name! +
        " group id: " +
        profile.groupId.toString());
  }

  @override
  void Mesibo_onGroupMembersRemoved(
      MesiboProfile profile, List<MesiboGroupMember?> members) {}

  @override
  void Mesibo_onGroupSettings(
      MesiboProfile profile,
      MesiboGroupSettings? groupSettings,
      MesiboMemberPermissions? memberPermissions,
      List<MesiboGroupPin?> groupPins) {}

  @override
  void Mesibo_onGroupError(MesiboProfile profile, int error) {}
}

/// Widget to display start video call title.
class InfoTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          "Login as User-1 from one device and as User-2 from another!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
