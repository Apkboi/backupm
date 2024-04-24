import 'package:audioplayers/audioplayers.dart';
import 'package:mentra/core/services/vibration/haptic_feedback_manager.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class SoundManager {
  static final cache = AudioCache();
  static final player = AudioPlayer();

  static Future<void> playMessageSentSound() async {
    final ringerStatus = await SoundMode.ringerModeStatus;

    if (ringerStatus != RingerModeStatus.silent) {
      await player.play(AssetSource('audio/sent2.mp3'));
    }
  }

  static Future<void> playMessageReceivedSound() async {
    final ringerStatus = await SoundMode.ringerModeStatus;

    if (ringerStatus != RingerModeStatus.silent) {
      await player.play(AssetSource('audio/sent.mp3'));
      HapticFeedbackManager.vibrate();
    }
  }

//
// static init(){
//
//   cache.loadAsset(path);
// }

// Add more methods for other sounds as needed
}
