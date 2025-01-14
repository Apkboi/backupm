import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BCLoginPasscodeField extends StatefulWidget {
  const BCLoginPasscodeField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BCLoginPasscodeField> createState() => _BCLoginPasscodeFieldState();
}

class _BCLoginPasscodeFieldState extends State<BCLoginPasscodeField> {
  // final _loginBloc = LoginBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: injector.get(),
      listener: _listenToLoginBloc,
      builder: (context, state) {
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
            injector.get<LoginBloc>().add(LoginUserEvent(
                email: "${injector.get<LoginBloc>().userPreview?.email}",
                password: answer));
            // injector.get<RegistrationBloc>().initialPasscode = answer;
            // context.read<BotChatCubit>().answerQuestion(
            //     id: widget.message.id,
            //     answer: answer,
            //     nextLoginStage: SignupStage.PASSCODE_CONFIRM);
          },
        );
      },
    );
  }

  void _listenToLoginBloc(BuildContext context, LoginState state) async {
    if (state is LoginLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is LoginSuccessState) {
      context.pop();
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: '****',
          nextFlow: BotChatFlow.talkToMentra);

      // context.goNamed(PageUrl.talkToMentraScreen);
    }

    if (state is LoginFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
      // _pinController.resetPin();
    }
  }
}
