import 'package:flutter/cupertino.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/routes.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/streaks/presentation/widget/new_streak_dialog.dart';

class DailyStreakChecker {
  static checkForStreak() {
    var user = injector.get<UserBloc>().appUser;
    if (user?.badgeUpdated ?? false) {
      // if (true) {

      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          CustomDialogs.showBottomSheet(
              rootNavigatorKey.currentContext!, const NewStreakDialog());
        },
      );
    }
  }
}
