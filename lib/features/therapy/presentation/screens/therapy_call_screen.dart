import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/core/constants/onboarding_texts.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/widgets/call/therapist_video_widget.dart';
import 'package:mentra/features/therapy/presentation/widgets/call/user_video_widget.dart';
import 'package:mentra/features/therapy/presentation/widgets/session_ended_dialog.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_review_sheet.dart';

class TherapyCallScreen extends StatefulWidget {
  const TherapyCallScreen(
      {super.key,
      required this.callerId,
      required this.calleeId,
      required this.sessionId,
      this.offer,
      this.therapist});

  final int callerId, calleeId;
  final dynamic sessionId;
  final SdpOffer? offer;
  final Caller? therapist;

  @override
  State<TherapyCallScreen> createState() => _TherapyCallScreenState();
}

class _TherapyCallScreenState extends State<TherapyCallScreen> {
  final callBloc = CallCubit();

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
      () {
        logger.w(widget.offer?.toJson());
        callBloc.startCall(
            widget.callerId, widget.calleeId, widget.offer, widget.sessionId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => callBloc,
      child: Scaffold(
        body: BlocConsumer<CallCubit, CallState>(
          listener: _listentoCallEvents,
          builder: (context, state) {
            var bloc = context.watch<CallCubit>();

            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TherapistVideoWidget(
                  remoteRenderer:
                      context.watch<CallCubit>().remoteRTCVideoRenderer,
                  caller: widget.therapist,
                )),
                Expanded(
                    child: BlocProvider.value(
                  value: context.read<CallCubit>(),
                  child: UserVideoWidget(
                    localRenderer:
                        context.watch<CallCubit>().localRTCVideoRenderer,
                    mirror: context.watch<CallCubit>().isFrontCameraSelected,
                    sessionId: widget.sessionId,
                    therapist: widget.therapist ?? Caller.dummy(),
                  ),
                ))
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    callBloc.dispose();
    CallKitService.instance.endCall();
    super.dispose();
  }

  void _listentoCallEvents(BuildContext context, CallState state) {
    if (state is CallEndedState) {
      _reviewCall(context);
    }
    if (state is EndCallLoadingState) {
      CustomDialogs.showLoading(context);
    }

    if (state is CallConnectingFailedState) {
      context.pop();
      CustomDialogs.error('Call connecting failed');
      CallKitService.instance.endCall();
      // callBloc.endCall();
    }
  }

  void _reviewCall(BuildContext context) async {
    CustomDialogs.hideLoading(context);
    final bool? writeReview = await CustomDialogs.showCustomDialog(
        TherapySessionEndedDialog(
          therapist: widget.therapist!,
        ),
        context);

    if (writeReview ?? false) {
      await CustomDialogs.showBottomSheet(
          rootNavigatorKey.currentState!.context,
          TherapyReviewSheet(
            therapist: widget.therapist!,
            sessionId: widget.sessionId,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          constraints: BoxConstraints(maxHeight: 0.9.sh));
    } else {
      context.pop();
      context.pop();
      context.pop();
    }
  }
}
