import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/widgets/call/therapist_video_widget.dart';
import 'package:mentra/features/therapy/presentation/widgets/call/user_video_widget.dart';

class TherapyCallScreen extends StatefulWidget {
  const TherapyCallScreen(
      {super.key, required this.callerId, required this.calleeId, this.offer});

  final int callerId, calleeId;
  final SdpOffer? offer;

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
        callBloc.startCall(widget.callerId, widget.calleeId, widget.offer);
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
                )),
                Expanded(
                    child: BlocProvider.value(
                  value: context.read<CallCubit>(),
                  child: UserVideoWidget(
                    localRenderer:
                        context.watch<CallCubit>().localRTCVideoRenderer,
                    mirror: context.watch<CallCubit>().isFrontCameraSelected,
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
      context.pop();
      CustomDialogs.success('Call Ended');
    }

    if (state is CallConnectingFailedState) {
      context.pop();
      CustomDialogs.error('Call connecting failed');
      callBloc.endCall();
    }
  }
}
