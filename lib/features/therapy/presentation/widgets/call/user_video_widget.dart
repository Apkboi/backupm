import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/presentation/bloc/call/call_cubit.dart';
import 'package:mentra/features/therapy/presentation/widgets/call/controll_sheet.dart';
import 'package:mentra/gen/assets.gen.dart';

class UserVideoWidget extends StatefulWidget {
  const UserVideoWidget(
      {super.key, required this.localRenderer, required this.mirror});

  final RTCVideoRenderer localRenderer;
  final bool mirror;

  @override
  State<UserVideoWidget> createState() => _UserVideoWidgetState();
}

class _UserVideoWidgetState extends State<UserVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          SizedBox(
            // color: Pallets.primary,
            width: 1.sw,
            child: RTCVideoView(
              widget.localRenderer,
              mirror: widget.mirror,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
          Positioned(
              bottom: 16,
              // left: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 1.sw - 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextView(
                              text: 'User',
                              fontWeight: FontWeight.w600,
                              color: Pallets.white,
                            ),
                            8.horizontalSpace,
                            ImageWidget(
                                imageUrl: Assets.images.pngs.speaking.path)
                          ],
                        ),
                      ),
                      HapticInkWell(
                        onTap: () {
                          _showControll(context);
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Pallets.white.withOpacity(0.2),
                          child: const Icon(
                            Icons.menu_rounded,
                            color: Pallets.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _showControll(BuildContext context) {
    CustomDialogs.showBottomSheet(
        context,
        BlocProvider.value(
            value: context.read<CallCubit>(),
            child: const CallControllSheet()));
  }
}
