import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';

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
      _showButton =
          widget.startDate.isBefore(now) && now.isBefore(widget.endDate);
    });
  }


  bool _showButton = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    _checkButtonVisibility();
    // Update button visibility every second to reflect real-time
    timer = Timer.periodic(
        const Duration(seconds: 1), (_) => _checkButtonVisibility());
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
}

void _groupCall() async {}
