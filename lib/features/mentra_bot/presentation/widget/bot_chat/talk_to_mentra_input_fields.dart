import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/BCTextInputField.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_avatar_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_confirm_passcode_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_email_preview_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_email_verification.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_login_passcode_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_select_year_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_set_passcode_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/bc_username_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/password_reset_email_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/password_reset_verification_screen.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/reset_passcode_field.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/bot_chat/user_email_field.dart';

import 'confirm_passcode_reset_field.dart';

class TalkToMentraInputFields extends StatefulWidget {
  const TalkToMentraInputFields({super.key, required this.currentMessage});

  final BotChatmessageModel currentMessage;

  @override
  State<TalkToMentraInputFields> createState() =>
      _TalkToMentraInputFieldsState();
}

class _TalkToMentraInputFieldsState extends State<TalkToMentraInputFields> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.currentMessage.answerType) {
      AnswerType.LOGIN_OPTION => 0.verticalSpace,
      AnswerType.WELCOME_OPTIONS => 0.verticalSpace,
      AnswerType.SIGNUP_OPTION => 0.horizontalSpace,
      AnswerType.CHAT => const BcTextInputField(),
      AnswerType.NUMBER => 0.horizontalSpace,
      AnswerType.AVATAR => BCAvatarField(
          message: widget.currentMessage,
        ),
      AnswerType.BIOMETRIC_OPTIONS => 0.verticalSpace,
      AnswerType.NONE => 0.horizontalSpace,
      AnswerType.EMAIL => BcUserEmailField(
          message: widget.currentMessage,
        ),
      AnswerType.EMAIL_VERIFICATION => BCEmailVerificationField(
          message: widget.currentMessage,
        ),
      AnswerType.SET_PASSCODE => BcSetPasscodeField(
          message: widget.currentMessage,
        ),
      AnswerType.SELECTYEAR => BcSelectYearField(
          message: widget.currentMessage,
        ),
      AnswerType.CONFIRMPASSCODE => BcConfirmPasscodeField(
          message: widget.currentMessage,
        ),
      AnswerType.USERNAME => BcUserNameField(message: widget.currentMessage),
      AnswerType.EMAIL_PREVIW =>
        BCEmailPreviewField(message: widget.currentMessage),
      AnswerType.LOGIN_PASSCODE =>
        BCLoginPasscodeField(message: widget.currentMessage),
      AnswerType.NOTIFICATION_OPTIONS => 0.verticalSpace,
      AnswerType.PASSWORD_RESET_EMAIL =>
        PasswordResetEmailField(message: widget.currentMessage),
      AnswerType.PASSWORD_RESET_OTP => PasswordResetVerificationField(
          message: widget.currentMessage,
        ),
      AnswerType.PASSWORD_RESET_PASSCODE =>
        ResetPasscodeField(message: widget.currentMessage),
      AnswerType.PASSWORD_RESET_CONFIRMPASSCODE =>
        const ConfirmPasswordResetCodeField()
    };
  }
}
