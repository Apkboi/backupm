import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
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
      // _showButton = true;
      _showButton = widget.startDate.isBefore(now) && now.isBefore(widget.endDate);
    });
  }

  static Mesibo _mesibo = Mesibo();
  static MesiboUI _mesiboUi = MesiboUI();
  String _mesiboStatus = 'Mesibo status: Not Connected.';

  bool _showButton = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _checkButtonVisibility();

    // Update button visibility every second to reflect real-time
    timer = Timer.periodic(const Duration(seconds: 1), (_) => _checkButtonVisibility());
  }

  @override
  Widget build(BuildContext context) {
    return widget.startDate.isBefore(DateTime.now()) &&
            DateTime.now().isBefore(widget.endDate)
        ? CustomNeumorphicButton(
            expanded: false,
            text: 'Join session',
            padding: const EdgeInsets.all(10),
            onTap: () async {

              _groupCall();
            },
            color: Pallets.primary)
        : const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initMesibo(String token) async {
    _mesiboUi.getUiDefaults().then((MesiboUIOptions options) {
      options.enableBackButton = true;
      options.appName = "Mentra";
      options.enableForward = false;
      options.statusBarColor = Pallets.primary.value;
      options.toolbarColor = Pallets.primary.value;
      _mesiboUi.setUiDefaults(options);
    });



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


    logger.i(widget.session.mesiboGroupId.toString());
    logger.i(injector.get<UserBloc>().appUser?.mesiboUserId);
    logger.i(injector.get<UserBloc>().appUser?.mesiboUserToken);
    logger.i(injector.get<UserBloc>().appUser?.email);
    MesiboProfile profile = MesiboProfile(
        groupId: widget.session.mesiboGroupId != null
            ? int.parse(widget.session.mesiboGroupId)
            : 6456580,
        uid: int.parse(injector.get<UserBloc>().appUser?.mesiboUserId),
        selfProfile: false,
        hash_id: 0);

    _mesiboUi.groupCall(profile, true, true, false, false);
  }
}
