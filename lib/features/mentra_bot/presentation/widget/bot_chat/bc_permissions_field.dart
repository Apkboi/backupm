import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/custom_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/services/permission_handler/permission_handler_service.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class BCPermissionsField extends StatelessWidget {
  const BCPermissionsField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            foregroundColor: Pallets.black,
            bgColor: Pallets.white,
            elevation: 0,
            isExpanded: false,
            padding: const EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(100),
            child: TextView(
              text: 'Yes, please!',
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            onPressed: () async {
              _requestPermission();

              // context.pushNamed(PageUrl.notificationAccess);
            },
          ),
        ),
        16.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            foregroundColor: Pallets.black,
            bgColor: Pallets.white,
            elevation: 0,
            isExpanded: false,
            padding: const EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(100),
            child: TextView(
              text: 'No,  not now',
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            onPressed: () {
              _notNow(context);
              // context.pushNamed(PageUrl.notificationAccess);
            },
          ),
        ),
      ],
    );
  }

  void _notNow(BuildContext context) {
    switch (message.permissionsStage) {
      case PermissionsStage.BIOMETRIC:
        context.read<BotChatCubit>().answerQuestion(
            id: message.id,
            answer: 'Not now',
            nextPermissionStage: PermissionsStage.NOTIFICATION);
      case PermissionsStage.NOTIFICATION:
        context.read<BotChatCubit>().answerQuestion(
              id: message.id,
              answer: 'Not now',
              nextFlow: BotChatFlow.talkToMentra,
            );
      case PermissionsStage.NONE:
        break;
    }
  }

  void _requestPermission() async {
    switch (message.permissionsStage) {
      case PermissionsStage.BIOMETRIC:
        await PermissionHandlerService().requestPermission(Permission.camera);
      case PermissionsStage.NOTIFICATION:
        await PermissionHandlerService()
            .requestPermission(Permission.notification);
      case PermissionsStage.NONE:
        break;
    }
  }
}
