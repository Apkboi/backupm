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

class PasswordResetVerificationField extends StatefulWidget {
  const PasswordResetVerificationField({
    super.key,
    required this.message,
  });

  final BotChatmessageModel message;

  @override
  State<PasswordResetVerificationField> createState() =>
      _PasswordResetVerificationFieldState();
}

class _PasswordResetVerificationFieldState
    extends State<PasswordResetVerificationField> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _bloc = PasswordResetBloc(injector.get());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BlocConsumer<PasswordResetBloc, PasswordResetState>(
              bloc: _bloc,
              listener: _listenToPasswordResetBloc,
              builder: (context, state) {
                return FilledTextField(
                  hint: "Enter code",
                  hasElevation: false,
                  outline: false,
                  controller: _controller,
                  validator: RequiredValidator(errorText: 'Enter code').call,
                  hasBorder: false,
                  inputType: TextInputType.number,
                  suffix: InkWell(
                    onTap: () {
                      _goToNextScreen(context);
                    },
                    child: const Icon(
                      Icons.send_rounded,
                      size: 20,
                    ),
                  ),
                  // onChanged: widget.onChanged,
                  // onFieldSubmitted: widget.onFieldSubmitted,
                  // onSaved: widget.onSaved,
                  radius: 50,
                  // preffix: const Icon(Iconsax.search_normal4),
                  // contentPadding: const EdgeInsets.symmetric(
                  //     vertical: 4, horizontal: 10),
                  fillColor: Pallets.white,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _goToNextScreen(BuildContext context) {
    // log('message');
    if (_formKey.currentState!.validate()) {
      // context.pushNamed(PageUrl.selectYearScreen);

      injector.get<PasswordResetBloc>().otp = _controller.text.trim();
      context.read<BotChatCubit>().answerQuestion(
          id: widget.message.id,
          answer: "*******",
          nextPasswordResetStage: PasswordResetStage.PASSCODE);

      // _bloc.add(VerifyPasswordResetOtpEvent(
      //     email: injector.get<PasswordResetBloc>().email,
      //     otp: _controller.text.trim()));
    }
  }

  void _listenToPasswordResetBloc(
      BuildContext context, PasswordResetState state) {
    if (state is VerifyPasswordResetOtpLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is VerifyPasswordResetOtpSuccessState) {
      context.pop();
    }

    if (state is VerifyPasswordResetOtpFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }
}
