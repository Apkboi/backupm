import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class BCLoginPasscodeField extends StatefulWidget {
  const BCLoginPasscodeField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BCLoginPasscodeField> createState() => _BCLoginPasscodeFieldState();
}

class _BCLoginPasscodeFieldState extends State<BCLoginPasscodeField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      inputType: TextInputType.number,
      hint: "Enter passcode",
      validator: MultiValidator([
        RequiredValidator(errorText: 'Enter passcode'),
        MaxLengthValidator(4, errorText: 'Passcode should be a 4 digit number'),
        MinLengthValidator(4, errorText: 'Passcode should be a 4 digit number'),
      ]).call,
      onAnswer: (answer) {
        injector.get<RegistrationBloc>().initialPasscode = answer;
        context.read<BotChatCubit>().answerQuestion(
            id: widget.message.id,
            answer: answer,
            nextSignupStage: SignupStage.PASSCODE_CONFIRM);
      },
    );
  }
}
