import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:mentra/core/di/injector.dart';

import '../../../app_config.dart';

class VibrationRequest {
  final FeedbackType feedbackType;
  final SendPort sendPort;

  VibrationRequest(this.feedbackType, this.sendPort);
}

class HapticFeedbackManager {
  static const isolateName = 'vibration_isolate';

  static Future<void> vibrate() async {
    Vibrate.feedback(FeedbackType.success);
  }
}
