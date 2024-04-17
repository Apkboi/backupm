import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BcSelectYearField extends StatefulWidget {
  const BcSelectYearField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BcSelectYearField> createState() => _BcSelectYearFieldState();
}

class _BcSelectYearFieldState extends State<BcSelectYearField> {
  @override
  Widget build(BuildContext context) {
    return InputBar(
      inputType: TextInputType.number,
      hint: "Enter birth year",
      inputFormatters: [
        LengthLimitingTextInputFormatter(4,
            maxLengthEnforcement: MaxLengthEnforcement.enforced),
      ],
      validator: MultiValidator([
        RequiredValidator(errorText: 'Enter birth year'),
        MinLengthValidator(4,
            errorText: 'Birth year should be exactly 4 digits')
      ]).call,
      onAnswer: (answer) {
        injector
            .get<RegistrationBloc>()
            .updateFields(birthYear: answer.toString());

        context.read<BotChatCubit>().answerQuestion(
            id: widget.message.id,
            answer: answer,
            nextSignupStage: SignupStage.PASSCODE);
        // context.pushNamed(PageUrl.setPasscode);
      },
    );
  }
}
