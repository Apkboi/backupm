import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class ResetPasscodeField extends StatefulWidget {
  const ResetPasscodeField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<ResetPasscodeField> createState() => _ResetPasscodeFieldState();
}

class _ResetPasscodeFieldState extends State<ResetPasscodeField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      inputType: TextInputType.number,
      hint: "Enter pin",
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),

      ],
      validator: MultiValidator([
        RequiredValidator(errorText: 'Enter pin'),
        MaxLengthValidator(4, errorText: 'Pin should be a 4 digit number'),
        MinLengthValidator(4, errorText: 'Pin should be a 4 digit number'),
      ]).call,
      onAnswer: (answer) {
        injector.get<PasswordResetBloc>().initialPasscode = answer;
        context.read<BotChatCubit>().answerQuestion(
            id: widget.message.id,
            answer: '****',
            nextPasswordResetStage: PasswordResetStage.CONFIRM_PASSCODE);
      },
    );
  }
}
