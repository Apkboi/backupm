import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';

class DailyStreakWidget extends StatefulWidget {
  const DailyStreakWidget({super.key});

  @override
  State<DailyStreakWidget> createState() => _DailyStreakWidgetState();
}

class _DailyStreakWidgetState extends State<DailyStreakWidget> {
  List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      bloc: injector.get(),
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Pallets.streakBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.r)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text:
                          'You’re on a ${injector.get<UserBloc>().appUser!.streak ?? 0}-day streak!',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    14.verticalSpace,
                    StreakWidget(3)
                  ],
                ),
              ),
              3.horizontalSpace,
              Column(
                children: [
                  // if (injector.get<UserBloc>().appUser!.badge != null)
                  //   ImageWidget(
                  //       size: 40,
                  //       onTap: () {
                  //         context.pushNamed(PageUrl.badgesScreen);
                  //       },
                  //       imageUrl:
                  //           injector.get<UserBloc>().appUser!.badge!.image.url),
                  // 3.verticalSpace,
                  InkWell(
                    onTap: () {
                      // context.pushNamed(PageUrl.badgesScreen);
                    },
                    child: CustomNeumorphicButton(
                        padding: const EdgeInsets.all(6),
                        expanded: false,
                        fgColor: Pallets.black,
                        onTap: () {
                          context.pushNamed(PageUrl.badgesScreen);
                        },
                        // text: 'View badges',
                        color: Pallets.secondary,
                        child: const TextView(
                          text: 'View badges',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  3.verticalSpace,
                ],
              )
            ],
          ),
        );
      },
    );
  }

  int get selectedDay {
    {
      var user = injector.get<UserBloc>().appUser!.streak;
      // Get the current day of the week (1 for Monday, 7 for Sunday)
      int currentDay = DateTime.now().weekday;

      // Adjust currentDay to be 0-based index (0 for Monday, 6 for Sunday)
      // currentDay = (currentDay + 5) % 7;

      logger.i(currentDay);

      // Select the correct item from the list based on the current day
      // String selectedDay = daysOfWeek[currentDay - 1];

      return currentDay - 1;
    }
  }
}

class DayOfWeek {
  final String name;
  final bool isInStreak;

  DayOfWeek({required this.name, required this.isInStreak});
}

class StreakWidget extends StatelessWidget {
  final int currentStreak;

  StreakWidget(this.currentStreak);

  List get selectedDays {
    List days = [];
    int currentDay = 3;
    int loopCount = (currentStreak > 7 ? 7 - currentDay : currentStreak);
    for (int i = currentDay; i >= loopCount; i--) {
      logger.w(i);
      days.add(i);
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    int currentDay = DateTime.now().weekday;
    selectedDays;

    List<DayOfWeek> daysOfWeek = [
      DayOfWeek(name: 'M', isInStreak: selectedDays.contains(1)),
      DayOfWeek(name: 'T', isInStreak: selectedDays.contains(2)),
      DayOfWeek(name: 'W', isInStreak: selectedDays.contains(3)),
      DayOfWeek(name: 'T', isInStreak: selectedDays.contains(4)),
      DayOfWeek(name: 'F', isInStreak: selectedDays.contains(5)),
      DayOfWeek(name: 'S', isInStreak: selectedDays.contains(6)),
      DayOfWeek(name: 'S', isInStreak: selectedDays.contains(7)),
    ];

    return Row(
      children: List.generate(
          daysOfWeek.length,
          (index) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: CircleAvatar(
                  radius: 13,
                  foregroundColor: Pallets.black,
                  // backgroundColor: daysOfWeek[index].isInStreak
                  backgroundColor: index == 0
                      ? Pallets.currentStreakBg
                      : Pallets.moodCheckerBg,
                  child: TextView(
                    text: daysOfWeek[index].name,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )),
    );
  }
}
