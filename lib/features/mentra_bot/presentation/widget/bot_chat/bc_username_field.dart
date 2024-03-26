import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BcUserNameField extends StatefulWidget {
  const BcUserNameField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BcUserNameField> createState() => _BcUserNameFieldState();
}

class _BcUserNameFieldState extends State<BcUserNameField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      hint: "Type name..",
      validator: RequiredValidator(errorText: 'Enter your name').call,
      onAnswer: (answer) {
        injector.get<RegistrationBloc>().updateFields(name: answer.trim());
        context.read<BotChatCubit>().answerQuestion(
            id: widget.message.id,
            answer: answer,
            nextSignupStage: SignupStage.AVARTER);
      },
    );
  }
}
