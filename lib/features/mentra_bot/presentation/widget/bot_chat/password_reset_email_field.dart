import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/core/di/injector.dart';

import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/authentication/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';


class PasswordResetEmailField extends StatefulWidget {
  const PasswordResetEmailField({super.key, required this.message});

  final BotChatmessageModel message;

  @override
  State<PasswordResetEmailField> createState() =>
      _PasswordResetEmailFieldState();
}

class _PasswordResetEmailFieldState extends State<PasswordResetEmailField> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  // final _bloc = PasswordResetBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<PasswordResetBloc, PasswordResetState>(
            listener: _listenToPasswordResetBloc,
            bloc: injector.get<PasswordResetBloc>(),
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: FilledTextField(
                  hint: "Type email here..",
                  hasElevation: false,
                  controller: _controller,
                  outline: false,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Enter email'),
                    EmailValidator(errorText: 'Invalid email')
                  ]).call,
                  hasBorder: false,
                  suffix: HapticInkWell(
                    onTap: () async {
                      _goToNextScreen(context);
                    },
                    child: const Icon(
                      Icons.send_rounded,
                      size: 20,
                    ),
                  ),
                  radius: 50,
                  // preffix: const Icon(Iconsax.search_normal4),
                  // contentPadding: const EdgeInsets.symmetric(
                  //     vertical: 16, horizontal: 16),
                  fillColor: Pallets.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    // log('message');
    if (_formKey.currentState!.validate()) {
      injector
          .get<PasswordResetBloc>()
          .add(SendPasswordResetOtpEvent(email: _controller.text.trim()));
    }
  }

  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is PasswordResetOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is PasswordResetOtpSuccessState) {
      context.pop();
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: _controller.text,
      nextPasswordResetStage: PasswordResetStage.OTP);
    }

    if (state is PasswordResetOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
