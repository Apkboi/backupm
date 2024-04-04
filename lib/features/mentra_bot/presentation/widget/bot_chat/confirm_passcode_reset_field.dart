import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/login/presentation/widgets/pin_view.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

enum PinMode {
  setPin,
  confirmPin,
}

class ConfirmPasswordResetCodeField extends StatefulWidget {
  const ConfirmPasswordResetCodeField({super.key});

  @override
  State<ConfirmPasswordResetCodeField> createState() =>
      _ConfirmPasswordResetCodeFieldState();
}

class _ConfirmPasswordResetCodeFieldState
    extends State<ConfirmPasswordResetCodeField> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = PINController();
  PinMode pinMode = PinMode.setPin;
  int activeCount = -1;
  String pin = '';
  String conFirmPin = '';
  final _bloc = PasswordResetBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
        bloc: _bloc,
        listener: _listenToPasswordResetBloc,
        builder: (context, state) {
          return InputBar(
            inputType: TextInputType.number,
            hint: "Enter pin",
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),

            ],
            validator: MultiValidator([
              RequiredValidator(errorText: 'Enter pin'),
              MaxLengthValidator(4,
                  errorText: 'Passcode should be a 4 digit number'),
              MinLengthValidator(4,
                  errorText: 'Passcode should be a 4 digit number'),
            ]).call,
            onAnswer: (answer) {
              if (injector.get<PasswordResetBloc>().confirmPasscode(answer)) {
                _bloc.add(ResetPasswordEvent(
                    code: injector.get<PasswordResetBloc>().otp,
                    password: answer));
              } else {
                context.read<BotChatCubit>().revertBack();
                CustomDialogs.error('Password mismatch');
              }
            },
          );
        },
      ),
    );
  }

  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is ResetPasswordLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is ResetPasswordSuccessState) {
      injector.get<RegistrationBloc>().clear();
      context.pop();
      context.read<BotChatCubit>().answerQuestion(
          id: 0,
          answer: "*******",
          nextFlow: BotChatFlow.login,
          nextLoginStage: LoginStage.PASSWORD_RESET_SUCCESS);
    }

    if (state is ResetPasswordFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  void _registerUser() {
    injector.get<RegistrationBloc>().updateFields(password: conFirmPin);
    // logger.i(injector.get<RegistrationBloc>().registrationPayload.toJson());
    _bloc.add(const ResetPasswordEvent(code: '', password: ''));
  }
}
