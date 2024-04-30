import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';

class CallControllSheet extends StatefulWidget {
  const CallControllSheet({super.key});

  @override
  State<CallControllSheet> createState() => _CallControllSheetState();
}

class _CallControllSheetState extends State<CallControllSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 1.sw,
      decoration: BoxDecoration(
          color: Pallets.black.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextView(
                      text: 'Therapist',
                      fontSize: 20,
                      color: Pallets.white,
                      fontWeight: FontWeight.w700,
                    ),
                    4.verticalSpace,
                    const TextView(
                      text: 'On call',
                      fontSize: 15,
                      color: Pallets.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              HapticInkWell(
                onTap: () {
                  context.pop();
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Pallets.white.withOpacity(0.5),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Pallets.white,
                  ),
                ),
              )
            ],
          ),
          25.verticalSpace,
          Wrap(
            alignment: WrapAlignment.start,
            // crossAxisAlignment: WrapCrossAlignment.start,
            // runAlignment: WrapAlignment.start,
            direction: Axis.horizontal,
            // // runSpacing: 20,
            runAlignment: WrapAlignment.start,
            spacing: 16,
            children: [
              _ControlSwitchButton(
                isActive: true,
                icon: ImageWidget(imageUrl: Assets.images.svgs.endCall),
                tittle: 'End',
                onTap: () {
                  context.pop();
                  context.pop();
                  // isActive:  context.read<CallCubit>()., // Adjust isActive based on your logic
                },
              ),
              _ControlSwitchButton(
                isActive:  context.watch<CallCubit>().isVideoOn, // Adjust isActive based on your logic
                icon: const Icon(Icons.switch_video),
                tittle: 'Camera',
                onTap: () {
                  context.read<CallCubit>().toggleCamera();

                },
              ),
              _ControlSwitchButton(
                isActive: !context
                    .watch<CallCubit>()
                    .isAudioOn, // Adjust isActive based on your logic
                icon: ImageWidget(imageUrl: Assets.images.svgs.mute),
                tittle: 'Mute',
                onTap: () {
                  context.read<CallCubit>().toggleMic();
                },
              ),
              _ControlSwitchButton(
                isActive: false, // Adjust isActive based on your logic
                icon: ImageWidget(imageUrl: Assets.images.svgs.flip),
                tittle: 'Flip',
                onTap: () {
                  context.read<CallCubit>().switchCamera();
                },
              ),
            ],
          ),
          75.verticalSpace
        ],
      ),
    );
  }
}

class _ControlSwitchButton extends StatefulWidget {
  const _ControlSwitchButton(
      {super.key,
      required this.isActive,
      required this.icon,
      required this.tittle,
      required this.onTap});

  final bool isActive;
  final Widget icon;
  final String tittle;
  final VoidCallback onTap;

  @override
  State<_ControlSwitchButton> createState() => _ControlSwitchButtonState();
}

class _ControlSwitchButtonState extends State<_ControlSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor:
                widget.isActive ? Pallets.red : Pallets.black.withOpacity(0.7),
            child: widget.icon,
          ),
          5.verticalSpace,
          TextView(text: widget.tittle, color: Pallets.white)
        ],
      ),
    );
  }
}