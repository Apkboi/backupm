import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedbackManager {
  static Future<void> vibrate() async {
    if (await Vibrate.canVibrate) {
      // Vibrate.vibrate();
      Vibrate.feedback(FeedbackType.success);
    }
  }
}
