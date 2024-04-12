import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/dashboard/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:mentra/features/mentra_bot/data/models/review_mood_model.dart';

class MoodCheckerWidget extends StatefulWidget {
  const MoodCheckerWidget({
    super.key,
  });

  @override
  State<MoodCheckerWidget> createState() => _MoodCheckerWidgetState();
}

class _MoodCheckerWidgetState extends State<MoodCheckerWidget> {
  late String mood;

  // final libraryBloc = Dashb(injector.get());

  @override
  void initState() {
    mood = injector.get<UserBloc>().appUser?.mood ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: injector.get(),
      listener: _listenToUserBloc,
      builder: (context, state) {
        return BlocConsumer<DashboardBloc, DashboardState>(
          bloc: injector.get(),
          listener: (context, state) {
            if (state is UpdateMoodCheckerSuccessState) {
              mood = state.response.data.mood;

              injector.get<UserBloc>().add(GetRemoteUser());
              setState(() {});
            }
            if (state is UpdateMoodCheckerFailureState) {
              CustomDialogs.error(state.error);
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
              decoration: BoxDecoration(
                  color: Pallets.moodCheckerBg.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextView(
                          text: 'How are you doing today?',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        6.verticalSpace,
                        const TextView(
                          text: 'Please tell us how you feel',
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                      ReviewMoodModel.allMoods.length,
                      (index) => InkWell(
                            onTap: () {
                              mood = ReviewMoodModel.allMoods[index].mood;
                              injector
                                  .get<DashboardBloc>()
                                  .add(UpdateMoodCheckerEvent(mood));

                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ImageWidget(
                                onTap: () {
                                  mood = ReviewMoodModel.allMoods[index].mood;
                                  injector
                                      .get<DashboardBloc>()
                                      .add(UpdateMoodCheckerEvent(mood));
                                  setState(() {});
                                },
                                shape: BoxShape.circle,
                                fit: BoxFit.scaleDown,
                                border:
                                    ReviewMoodModel.allMoods[index].mood == mood
                                        ? Border.all(
                                            color: Pallets.moodCheckerBorder)
                                        : null,
                                imageUrl:
                                    ReviewMoodModel.allMoods[index].avatar,
                                height: 40.h,
                                width: 40.w,
                              ),
                            ),
                          ))
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _listenToUserBloc(BuildContext context, UserState state) {
    mood = injector.get<UserBloc>().appUser?.mood ?? mood;
    setState(() {});
  }
}
