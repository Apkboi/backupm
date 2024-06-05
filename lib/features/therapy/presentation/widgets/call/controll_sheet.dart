import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/widgets/end_therapy_session_dialog.dart';
import 'package:mentra/features/therapy/presentation/widgets/session_ended_dialog.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_review_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';
import '../../../data/models/incoming_response.dart';

class CallControllSheet extends StatefulWidget {
  const CallControllSheet({super.key, this.sessionId, required this.caller});

  final dynamic sessionId;
  final Caller caller;

  @override
  State<CallControllSheet> createState() => _CallControllSheetState();
}

class _CallControllSheetState extends State<CallControllSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 1.sw,
      decoration: BoxDecoration(
        color: Pallets.black.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r),
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           TextView(
          //             text: widget.caller.name,
          //             fontSize: 20,
          //             color: Pallets.white,
          //             fontWeight: FontWeight.w700,
          //           ),
          //           4.verticalSpace,
          //           const TextView(
          //             text: 'On call',
          //             fontSize: 15,
          //             color: Pallets.white,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ],
          //       ),
          //     ),
          //     HapticInkWell(
          //       onTap: () {
          //         context.pop();
          //       },
          //       child: CircleAvatar(
          //         radius: 18,
          //         backgroundColor: Pallets.white.withOpacity(0.5),
          //         child: const Icon(
          //           Icons.close_rounded,
          //           size: 16,
          //           color: Pallets.white,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          5.verticalSpace,
          Wrap(
            alignment: WrapAlignment.start,
            // crossAxisAlignment: WrapCrossAlignment.start,
            // runAlignment: WrapAlignment.start,
            direction: Axis.horizontal,
            // // runSpacing: 20,
            runAlignment: WrapAlignment.start,
            spacing: 16,
            children: [
              ControlSwitchButton(
                isActive: true,
                icon: ImageWidget(imageUrl: Assets.images.svgs.endCall),
                tittle: 'End',
                onTap: () {
                  _endCall(context);

                  // isActive:  context.read<CallCubit>()., // Adjust isActive based on your logic
                },
              ),
              ControlSwitchButton(
                isActive: !context
                    .watch<CallCubit>()
                    .isVideoOn, // Adjust isActive based on your logic
                icon: Icon(context.watch<CallCubit>().isVideoOn
                    ? Icons.videocam_outlined
                    : Icons.videocam_off_outlined),
                tittle: 'Camera',
                onTap: () {
                  context.read<CallCubit>().toggleCamera();
                },
              ),
              ControlSwitchButton(
                isActive: !context
                    .watch<CallCubit>()
                    .isAudioOn, // Adjust isActive based on your logic
                icon: Icon(
                  context.watch<CallCubit>().isAudioOn
                      ? Icons.mic
                      : Icons.mic_off_sharp,
                  size: 30,
                  color: Pallets.white,
                ),
                tittle: 'Mute',
                onTap: () {
                  context.read<CallCubit>().toggleMic();
                },
              ),
              ControlSwitchButton(
                isActive: false, // Adjust isActive based on your logic
                icon: const Icon(Icons.cameraswitch_rounded),
                tittle: 'Flip',
                onTap: () {
                  context.read<CallCubit>().switchCamera();
                },
              ),
            ],
          ),
          // 75.verticalSpace
        ],
      ),
    );
  }

  // void _endCall(BuildContext context) {
  //   CustomDialogs.showBottomSheet(
  //       context, EndTherapySessionDialog(sessionId: widget.sessionId));
  // }

  void _endCall(BuildContext context) async {
    final bool? sessionEnded = await CustomDialogs.showBottomSheet(
        context, EndTherapySessionDialog(sessionId: widget.sessionId));

    if (sessionEnded ?? false) {
      CallKitService.instance.endAllCalls();
      context.read<CallCubit>().endCall();
      // final bool? writeReview = await CustomDialogs.showCustomDialog(
      //     TherapySessionEndedDialog(
      //       therapist: widget.caller,
      //     ),
      //     context);
      //
      //
      // // context.pop();
      // // context.pop();
      // // logger.i(writeReview);
      //
      // if (writeReview ?? false) {
      //   final bool? wroteFeedback = await CustomDialogs.showBottomSheet(
      //       context,
      //       TherapyReviewSheet(
      //         therapist: widget.caller,
      //         sessionId: widget.sessionId,
      //       ),
      //       shape: const RoundedRectangleBorder(
      //           borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(16),
      //         topRight: Radius.circular(16),
      //       )),
      //       constraints: BoxConstraints(maxHeight: 0.9.sh));
      //
      //   if (wroteFeedback ?? false) {
      //     await CustomDialogs.showBottomSheet(
      //         context,
      //         SuccessDialog(
      //           tittle: feedbackSuccessMessage,
      //           onClose: () {
      //             context.pop();
      //           },
      //         ),
      //         shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(16),
      //           topRight: Radius.circular(16),
      //         )),
      //         constraints: BoxConstraints(maxHeight: 0.9.sh));
      //     context.pop();
      //     context.pop();
      //   }else{
      //     context.pop();
      //     context.pop();
      //   }
      //
      // } else {
      //   context.pop();
      //   context.pop();
      // }
    }
  }
}

class ControlSwitchButton extends StatefulWidget {
  const ControlSwitchButton(
      {super.key,
      required this.isActive,
      required this.icon,
      required this.tittle,
      required this.onTap,
      this.bgColor});

  final bool isActive;
  final Widget icon;
  final String tittle;
  final VoidCallback onTap;
  final Color? bgColor;

  @override
  State<ControlSwitchButton> createState() => ControlSwitchButtonState();
}

class ControlSwitchButtonState extends State<ControlSwitchButton> {
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
