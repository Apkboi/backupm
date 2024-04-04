import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/input_bar.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';

class BcConfirmPasscodeField extends StatefulWidget {
  const BcConfirmPasscodeField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<BcConfirmPasscodeField> createState() => _BcConfirmPasscodeFieldState();
}

class _BcConfirmPasscodeFieldState extends State<BcConfirmPasscodeField> {
  final _registrationBloc = RegistrationBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: _listenToRegistrationBloc,
      bloc: _registrationBloc,
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
            if (injector.get<RegistrationBloc>().confirmPasscode(answer)) {
              injector.get<RegistrationBloc>().updateFields(password: answer);
              // logger.i(injector.get<RegistrationBloc>().registrationPayload.toJson());
              _registrationBloc.add(RegisterEvent(
                  payload:
                      injector.get<RegistrationBloc>().registrationPayload));


            } else {
              context.read<BotChatCubit>().revertBack();
              CustomDialogs.error('Pin mismatch');
            }
          },
        );
      },
    );
  }

  void _listenToRegistrationBloc(
      BuildContext context, RegistrationState state) {
    if (state is RegistrationLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is RegistrationSuccessState) {
      injector.get<RegistrationBloc>().clear();

      context.pop();
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: '****',
          nextPermissionStage: PermissionsStage.BIOMETRIC,
          nextFlow: BotChatFlow.permissions);
      // context.pushNamed(PageUrl.biometricAccess);
    }

    if (state is RegistrationFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
