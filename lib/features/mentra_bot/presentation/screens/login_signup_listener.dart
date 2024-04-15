import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/daily_streak/daily_streak_checker.dart';
import 'package:mentra/features/authentication/login/presentation/bloc/login_bloc.dart';
import 'package:mentra/features/authentication/registration/presentation/bloc/registration_bloc.dart';
import 'package:mentra/features/mentra_bot/dormain/services/mentra_message_mapper.dart';
import 'package:mentra/features/mentra_bot/presentation/blocs/signup_chat/bot_chat_cubit.dart';
import 'package:mentra/features/streaks/presentation/widget/new_streak_dialog.dart';

class LoginSignupListener extends StatefulWidget {
  const LoginSignupListener({super.key, required this.child});

  final Widget child;

  @override
  State<LoginSignupListener> createState() => _LoginSignupListenerState();
}

class _LoginSignupListenerState extends State<LoginSignupListener> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<LoginBloc, LoginState>(
          bloc: injector.get(), listener: _listenToLoginStates),
      BlocListener<RegistrationBloc, RegistrationState>(
          bloc: injector.get(), listener: _listenToRegistrationStates),
    ], child: widget.child);
  }

  void _listenToLoginStates(BuildContext context, LoginState state) {
    if (state is LoginOauthSuccessState) {
      // context.pop();
      if (!state.response.data.newUser) {
        _talkToMentraWithAuthenticationMessages(context);
      }
    }

    if (state is LoginSuccessState) {
      _talkToMentraWithAuthenticationMessages(context);
    }

    logger.w('CALLED LISTENER');
  }

  void _listenToRegistrationStates(BuildContext context,
      RegistrationState state) {
    if (state is OauthSuccessState) {
      if (!state.response.data.newUser) {
        // DailyStreakChecker.checkForStreak();
        _talkToMentraWithAuthenticationMessages(context);
      }
    }

    if (state is SignupCompleteState) {
      _talkToMentraWithAuthenticationMessages(context);
    }
  }

  void _talkToMentraWithAuthenticationMessages(BuildContext context) {
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
          () {
        var authMessges = context
            .read<BotChatCubit>()
            .stagedMessages
            .where((element) => element.isTyping == false)
            .toList();

        logger.i(authMessges.map((e) => {e.message + e.answer.toString()}));

        context.pushNamed(PageUrl.talkToMentraScreen, queryParameters: {
          PathParam.authMessages: jsonEncode(
              MentraMessageMapper.authMessagesToMentraMessages(authMessges))
        });
      },
    );
  }
}
