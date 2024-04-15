import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/image_widget.dart';
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
  List<String> daysOfWeek = ['M', 'T', 'W', 'TH', 'F', 'S', 'SU'];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text:
                          'You’re on a ${injector.get<UserBloc>().appUser!.streak?.duration ?? 0}-day streak!',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    14.verticalSpace,
                    Row(
                      children: List.generate(
                          daysOfWeek.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircleAvatar(
                                  radius: 13,
                                  foregroundColor: Pallets.black,
                                  backgroundColor:
                                      selectedDay == daysOfWeek[index]
                                          ? Pallets.currentStreakBg
                                          : Pallets.moodCheckerBg,
                                  child: TextView(
                                    text: daysOfWeek[index],
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  if (injector.get<UserBloc>().appUser!.streak != null)
                    ImageWidget(
                        size: 40,
                        onTap: () {
                          context.pushNamed(PageUrl.badgesScreen);
                        },
                        imageUrl: injector
                            .get<UserBloc>()
                            .appUser!
                            .streak!
                            .image
                            .url),
                  3.verticalSpace,
                  InkWell(
                    onTap: () {
                      context.pushNamed(PageUrl.badgesScreen);
                    },
                    child: const TextView(
                      text: 'View badges',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
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

  String get selectedDay {
    {
      // Get the current day of the week (1 for Monday, 7 for Sunday)
      int currentDay = DateTime.now().weekday;

      // Adjust currentDay to be 0-based index (0 for Monday, 6 for Sunday)
      // currentDay = (currentDay + 5) % 7;

      logger.i(currentDay);

      // Select the correct item from the list based on the current day
      String selectedDay = daysOfWeek[currentDay - 1];

      return selectedDay;
    }
  }
}
