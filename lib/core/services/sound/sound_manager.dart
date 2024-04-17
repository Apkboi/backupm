import 'package:audioplayers/audioplayers.dart';
import 'package:mentra/core/services/vibration/haptic_feedback_manager.dart';

class SoundManager {
  static final cache = AudioCache();
  static final player = AudioPlayer();

  static Future<void> playMessageSentSound() async {

    await player.play(AssetSource('audio/sent.mp3'));
  }

  static Future<void> playMessageReceivedSound() async {
    await player.play(AssetSource('audio/received.mp3'));
    HapticFeedbackManager.vibrate();

  }

//
// static init(){
//
//   cache.loadAsset(path);
// }

// Add more methods for other sounds as needed
}
