import 'package:mentra/gen/assets.gen.dart';

class CallControl {
  final String imagePath;
  final String name;

  CallControl({required this.imagePath, required this.name});
}

final List<CallControl> callControls = [
  CallControl(imagePath: Assets.images.svgs.endCall, name: "End Call"),
  CallControl(imagePath: Assets.images.svgs.speaker, name: "Speaker"),
  CallControl(imagePath: Assets.images.svgs.mute, name: "Mute"),
  CallControl(imagePath: Assets.images.svgs.mute, name: "Mute"),
  // Duplicate entry removed
  CallControl(imagePath: Assets.images.svgs.flip, name: "Flip Camera"),
];
