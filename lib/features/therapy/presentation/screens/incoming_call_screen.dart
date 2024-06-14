import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/incoming_call_wave.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/core/services/calling_service/flutter_call_kit_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/therapy/data/models/incoming_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:vibration/vibration.dart';

class IncomingCallScreen extends StatefulWidget {
  const IncomingCallScreen(
      {super.key,
      required this.callerId,
      required this.calleeId,
      this.offer,
      this.caller,
      this.sessionId});

  final int callerId, calleeId;
  final dynamic sessionId;
  final SdpOffer? offer;
  final Caller? caller;

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  @override
  void initState() {
    // Future.delayed(
    //   const Duration(seconds: 30),
    //   () {
    //     if (mounted) {
    //       rootNavigatorKey.currentState!.context.pop();
    //     }
    //   },
    // );
    Vibration.vibrate(duration: 3000, amplitude: 128);
    super.initState();
  }

  @override
  void dispose() {
    Vibration.cancel();
    CallKitService.instance.endAllCalls();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallCubit, CallState>(
      bloc: injector.get(),
      listener: _listenToCallEvent,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFCBF5E5),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 100.verticalSpace,
                Center(
                    child: ImageWidget(
                  imageUrl: widget.caller?.avatar?? Assets.images.pngs.avatar3.path,
                  size: 120,
                )),
                10.verticalSpace,
                 TextView(
                  text: widget.caller?.name??"Therapist",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                5.verticalSpace,
                const TextView(text: 'Incoming call'),
                70.verticalSpace,
                // Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 90.h,
                        width: 90.w,
                        child: Align(
                          child: IncomingCallAnimation(
                            color: Pallets.red,
                            size: 60,
                            icon: ImageWidget(
                                imageUrl: Assets.images.svgs.endCall),
                            onTap: () {
                              _declineCall(context);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                        width: 90.w,
                        child: IncomingCallAnimation(
                          color: Pallets.successGreen,
                          size: 60,
                          icon: const Icon(
                            Icons.phone_rounded,
                            color: Pallets.white,
                          ),
                          onTap: () {
                            // Vibrate.vibrate();
                            _answerCall(context, '1');
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _answerCall(BuildContext context, String descriptionId) {
    // Navigator.pop(rootNavigatorKey.currentState!.context);

    // context.pushNamed(PageUrl.therapyCallScreen, queryParameters: {
    //   PathParam.calleeId: injector.get<UserBloc>().appUser?.id.toString(),
    //   PathParam.callerId: descriptionId,
    // });

    // log
    // Navigator.pop(c);

    context.pushNamed(PageUrl.therapyCallScreen, queryParameters: {
      PathParam.calleeId: injector.get<UserBloc>().appUser?.id.toString(),
      PathParam.callerId: widget.callerId.toString(),
      PathParam.sessionId: widget.sessionId.toString(),
      PathParam.caller: jsonEncode(widget.caller?.toJson()),
      if (widget.offer != null)
        PathParam.offer: jsonEncode(widget.offer?.toJson()),
    });
    // CallKitService.instance.an
  }

  void _listenToCallEvent(BuildContext context, CallState state) {
    if (state is AcceptCallState) {
      // CustomDialogs.success('Event received');
      _answerCall(context, state.callerId);
    }

    if (state is CallEndedState) {
      // context.pop();
      CallKitService.instance.endAllCalls();
    }
  }

  void _declineCall(BuildContext context) {
    // injector.get<CallCubit>().endCall();
    CallKitService.instance.endAllCalls();
    Navigator.pop(context);
  }
}
