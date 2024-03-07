import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class BCEmailPreviewField extends StatefulWidget {
  const BCEmailPreviewField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BCEmailPreviewField> createState() => _BCEmailPreviewFieldState();
}

class _BCEmailPreviewFieldState extends State<BCEmailPreviewField> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: _listenToLoginBloc,
      bloc: injector.get(),
      builder: (context, state) {
        return InputBar(
          hint: "Type email here..",
          validator: MultiValidator([
            RequiredValidator(errorText: 'Enter email'),
            EmailValidator(errorText: 'Invalid email')
          ]).call,
          onAnswer: (answer) {
            email = answer;
            injector.get<LoginBloc>().add(LoginPreviewEvent(email: answer));
          },
        );
      },
    );
  }

  void _listenToLoginBloc(BuildContext context, LoginState state) {
    if (state is LoginPreviewLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is LoginPreviewSuccessState) {
      context.pop();
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: email,
          nextLoginStage: LoginStage.PASSCODE);
    }

    if (state is LoginPreviewFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
