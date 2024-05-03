import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:mentra/core/di/injector.dart';

class VibrationRequest {
  final FeedbackType feedbackType;
  final SendPort sendPort;

  VibrationRequest(this.feedbackType, this.sendPort);
}

class HapticFeedbackManager {
  static const isolateName = 'vibration_isolate';

  static Future<void> vibrate() async {
    Vibrate.feedback(FeedbackType.success);

    try {
      final receivePort = ReceivePort();
      final isolate = await Isolate.spawn(_isolateEntry,
          VibrationRequest(FeedbackType.success, receivePort.sendPort),
          onError: receivePort.sendPort);

      receivePort.listen((message) {
        if (message == 'done') {
          isolate.kill();
        } else if (message is PlatformException) {
          logger.w('Error in isolate: ${message.message}');
        }
      });
    } catch (e) {
      logger.w(e.toString());
    }
  }

  static void _isolateEntry(VibrationRequest request) async {
    try {
      Vibrate.feedback(FeedbackType.success);
      request.sendPort.send('done');
      // logger.w('done');
    } catch (error) {
      request.sendPort.send(PlatformException(
          code: 'vibration_error', message: error.toString()));
    }
  }

  void handleClick() async {
    vibrate();
    // Perform other actions after vibration request is sent to isolate
  }
}
