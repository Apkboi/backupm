import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/bot_chat/bot_chat_cubit.dart';

class BcUserEmailField extends StatefulWidget {
  const BcUserEmailField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BcUserEmailField> createState() => _BcUserEmailFieldState();
}

class _BcUserEmailFieldState extends State<BcUserEmailField> {
  final _bloc = RegistrationBloc(injector.get());
  String email = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: _listenToRegistrationBloc,
      bloc: _bloc,
      builder: (context, state) {
        return InputBar(
          hint: "Type email here..",
          validator: MultiValidator([
            RequiredValidator(errorText: 'Enter email'),
            EmailValidator(errorText: 'Invalid email')
          ]).call,
          onAnswer: (answer) {
            email = answer;
            _bloc.add(SendOtpEvent(email: email));

          },
        );
      },
    );
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is SendOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is SendOtpSuccessState) {
      context.pop();
      injector.get<RegistrationBloc>().updateFields(email: email);
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: email,
          nextSignupStage: SignupStage.EMAIL_VERIFICATION);

      // CustomDialogs.success('Verification code sent');

      // context.pushNamed(PageUrl.emailVerificationScreen);
    }

    if (state is SendOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
