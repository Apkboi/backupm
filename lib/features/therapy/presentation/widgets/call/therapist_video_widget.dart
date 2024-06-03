import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/widgets/call/controll_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';

import '../../../data/models/incoming_response.dart';

class TherapistVideoWidget extends StatefulWidget {
  const TherapistVideoWidget({
    super.key,
    required this.remoteRenderer,
    required this.caller,
  });

  final RTCVideoRenderer remoteRenderer;
  final Caller? caller;

  @override
  State<TherapistVideoWidget> createState() => _TherapistVideoWidgetState();
}

class _TherapistVideoWidgetState extends State<TherapistVideoWidget> {
  bool remoteVideoEnabled = false;
  bool remoteAudioEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Pallets.black),
      child: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            child: RTCVideoView(
              widget.remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
          BlocConsumer<CallCubit, CallState>(
            listener: _listenToCallCubit,
            buildWhen: _buildWhen,
            builder: (context, state) {
              if (state is CallConnectingState) {
                return const Center(
                  child: TextView(
                    text: 'Connecting...',
                    color: Pallets.white,
                    fontSize: 18,
                  ),
                );
              }

              if (state is CallReConnectingState) {
                return const Center(
                  child: TextView(
                    text: 'Reconnecting...',
                    color: Pallets.white,
                    fontSize: 18,
                  ),
                );
              }

              return _RemoteControllWidget(
                  caller: widget.caller,
                  videoEnabled: remoteVideoEnabled,
                  audioEnabled: remoteAudioEnabled);
            },
          ),
          Positioned(
              bottom: 16,
              left: 16,
              child: Row(
                children: [
                  TextView(
                    text: widget.caller?.name ?? '....',
                    fontWeight: FontWeight.w600,
                    color: Pallets.white,
                  ),
                  8.horizontalSpace,
                  ImageWidget(imageUrl: Assets.images.pngs.speaking.path)
                ],
              ))
        ],
      ),
    );
  }

  void _listenToCallState(BuildContext context, CallState state) {}

  bool _buildWhen(CallState previous, CallState current) {
    return current is CallConnectingState ||
        current is CallConnectedState ||
        current is CallReConnectingState;
  }

  void _listenToCallCubit(BuildContext context, CallState state) {
    if (state is CallActionState) {
      if (state.response.action == "videoStateChanged") {
        remoteVideoEnabled = state.response.value == "enabled";
      }
      if (state.response.action == "audioStateChanged") {
        remoteAudioEnabled = state.response.value == "enabled";
      }
    }
  }
}

class _RemoteControllWidget extends StatelessWidget {
  const _RemoteControllWidget(
      {super.key,
      required this.caller,
      required this.videoEnabled,
      required this.audioEnabled});

  final Caller? caller;
  final bool videoEnabled;
  final bool audioEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: !videoEnabled ? Colors.transparent : Pallets.black),
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        children: [
          if (videoEnabled)
            Center(
              child: ImageWidget(
                imageUrl: caller?.avatar ?? Assets.images.pngs.avatar3.path,
                size: 70,
              ),
            ),
          Positioned(
              right: 16,
              top: 70,
              child: !audioEnabled
                  ? const Icon(
                      Icons.mic_rounded,
                      color: Pallets.grey,
                      size: 30,
                    )
                  : const Icon(
                      Icons.mic_off_rounded,
                      color: Pallets.grey,
                      size: 35,
                    ))
        ],
      ),
    );
  }
}
