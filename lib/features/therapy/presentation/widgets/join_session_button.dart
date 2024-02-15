import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/permission_handler/permission_handler_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mesibo/presentation/bloc/mesibo_cubit.dart';
import 'package:mesibo_flutter_sdk/mesibo.dart';
import 'package:permission_handler/permission_handler.dart';

class SessionButton extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const SessionButton(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);

  @override
  _SessionButtonState createState() => _SessionButtonState();
}

class _SessionButtonState extends State<SessionButton> {
  bool _showButton = false;
  final bloc = MesiboCubit();

  @override
  void initState() {
    super.initState();
    _checkButtonVisibility();
    // Update button visibility every second to reflect real-time
    Timer.periodic(const Duration(seconds: 1), (_) => _checkButtonVisibility());
  }

  void _checkButtonVisibility() {
    final now = DateTime.now();
    setState(() {
      _showButton = true;
      // _showButton = widget.startDate.isBefore(now) && now.isBefore(widget.endDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showButton
        ? CustomNeumorphicButton(
            expanded: false,
            text: 'Join session',
            padding: const EdgeInsets.all(10),
            onTap: () async {
              // await bloc.initialize();
              _groupCall();
            },
            color: Pallets.primary)
        : const SizedBox();
  }
}

void _groupCall() async {
  // if (!injector.get<MesiboCubit>().mOnline) return;

  // MesiboProfile profile = await injector.get<Mesibo>().getGroupProfile( 2988820);
  MesiboProfile profile =
      MesiboProfile(groupId: 2988983, uid: 6361887, selfProfile: false);
  // logger.i(profile.getGroupProfile()?.status);
  // await injector.get<MesiboUI>().launchMessaging(profile);

  await PermissionHandlerService().requestPermission(Permission.camera);
  await PermissionHandlerService().requestPermission(Permission.audio);
  await PermissionHandlerService().requestPermission(Permission.phone);
  await PermissionHandlerService().requestPermission(Permission.contacts);

  // var userP = await injector.get<Mesibo>().getUserProfile('xyz@example.com');

  // await injector.get<MesiboUI>().call(userP, false);

  await injector.get<MesiboUI>().groupCall(profile, true, true, true, true);

  // logger.e(e.toString());
  // logger.e(stack.toString());
  //
}
