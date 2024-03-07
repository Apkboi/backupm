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

class BCEmailVerificationField extends StatefulWidget {
  const BCEmailVerificationField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BCEmailVerificationField> createState() =>
      _BCEmailVerificationFieldState();
}

class _BCEmailVerificationFieldState extends State<BCEmailVerificationField> {
  final _bloc = RegistrationBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      bloc: _bloc,
      listener: _listenToRegistrationBloc,
      builder: (context, state) {
        return InputBar(
          hint: "Enter code",
          inputType: TextInputType.number,
          validator: RequiredValidator(errorText: 'Enter code').call,
          onAnswer: (answer) {
            _bloc.add(VerifyOtpEvent(
                email:
                    injector.get<RegistrationBloc>().registrationPayload.email,
                otp: answer.trim()));
          },
        );
      },
    );
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is VerifyOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is VerifyOtpSuccessState) {
      context.pop();
      // injector.get<RegistrationBloc>().updateFields(email: injector.);
      // CustomDialogs.success('Verification code sent');

      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: "*******",
          nextSignupStage: SignupStage.YEAR);
      // context.pushNamed(PageUrl.selectYearScreen);
    }

    if (state is VerifyOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
