import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class AudioPlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const AudioPlayerWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _AudioPlayerWidgetState();
  }
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
// Use initial values from player
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
// Subscriptions only can be closed asynchronously,
// therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          color: Pallets.splash, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Text(
                _position != null
                    ? _positionText
                    : _duration != null
                        ? _durationText
                        : '',
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Pallets.white),
              ),
              5.horizontalSpace,
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: SliderComponentShape.noThumb,
                    // Remove thumb
                    trackHeight: 5,
                    // Increase height
                    activeTrackColor: Colors.white,
                    // Change value color
                    inactiveTrackColor: Colors.grey.withOpacity(0.2),
                    // Change inactive track color
                    overlayColor: Colors.transparent, // Remove overlay
                  ),
                  child: Slider(
                    onChanged: (value) {
                      final duration = _duration;
                      if (duration == null) {
                        return;
                      }
                      final position = value * duration.inMilliseconds;
                      player.seek(Duration(milliseconds: position.round()));
                    },
                    value: (_position != null &&
                            _duration != null &&
                            _position!.inMilliseconds > 0 &&
                            _position!.inMilliseconds <
                                _duration!.inMilliseconds)
                        ? _position!.inMilliseconds / _duration!.inMilliseconds
                        : 0.0,
                  ),
                ),
              ),
              5.horizontalSpace,
              Text(
                _durationText,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Pallets.white),
              ),
            ],
          ),
          Row(
            // mainAxisSize: MainAxisSize.sp,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HapticInkWell(
                key: const Key('back'),
                onTap: (_position?.inSeconds ?? 0) > 10
                    ? () {
                        player
                            .seek(Duration(seconds: _position!.inSeconds - 10));
                      }
                    : () {
                        player.seek(const Duration(seconds: 0));
                      },
                child: const Icon(
                  Icons.replay_10,
                  size: 25,
                  color: Pallets.white,
                ),
              ),
              HapticInkWell(
                key: const Key('play_button'),
                onTap: _isPlaying ? _pause : _play,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Pallets.white.withOpacity(0.2),
                  child: _isPlaying
                      ? const Icon(
                          Iconsax.pause5,
                          size: 16,
                          color: Pallets.white,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          size: 30,
                          color: Pallets.white,
                        ),
                ),
              ),
              HapticInkWell(
                key: const Key('foward'),
                onTap: (_duration?.inSeconds ?? 0) -
                            (_position?.inSeconds ?? 0) >
                        10
                    ? () {
                        player
                            .seek(Duration(seconds: _position!.inSeconds + 10));
                      }
                    : null,
                child: const Icon(
                  Icons.forward_10_rounded,
                  size: 25,
                  color: Pallets.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}
