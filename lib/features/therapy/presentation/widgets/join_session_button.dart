import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
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
  final TherapySession session;

  SessionButton(
      {required this.startDate, required this.endDate, required this.session});

  @override
  _SessionButtonState createState() => _SessionButtonState();
}

class _SessionButtonState extends State<SessionButton> {
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
  // DemoUser user1 = DemoUser(
  //     "168a28b89c8000016ebbd246fc64ccdd92444cf4557d0e444ac8d2iabc21eeb520",
  //     'vic@gmail.com');

  // IOS USER
  DemoUser user1 = DemoUser(
      "d6582a9d25c85cbf4c9386e5d3529cdbb8f89d911dab801fae224ad1e4ga1499143eaf",
      'victor@gmail.com');
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
  Widget build(BuildContext context) {
    return _showButton
        ? CustomNeumorphicButton(
            expanded: false,
            text: 'Join session',
            padding: const EdgeInsets.all(10),
            onTap: () async {
              // await injector.get<MesiboCubit>().startGroupCall();
              // await bloc.initialize();
              // initMesibo(user1.token);
              // MesiboService service = MesiboService();
              //
              // service.groupCall('Mentra');
              _groupCall();
              // _loginUser1();
            },
            color: Pallets.primary)
        : const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
  }


  void initMesibo(String token) async {
    // optional - only to show alert in AUTHFAIL case

    Future<String> asyncAppId = _mesibo.getAppIdForAccessToken();
    asyncAppId.then((String appid) {
      mAppId = appid;
    });







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
    //
    MesiboProfile profile =
        // MesiboProfile(groupId: 2988983, uid: 6361887, selfProfile: false);

        // IOS PROFILE
        MesiboProfile(groupId: 2988983, uid: 63611207, selfProfile: false);
    // MesiboProfile profile = MesiboProfile(
    //     groupId: widget.session.mesiboGroupId,
    //     uid: injector.get<UserBloc>().appUser?.mesiboUserId,
    //     selfProfile: false);

    _mesiboUi.groupCall(profile, true, true, false, false);
  }


}


