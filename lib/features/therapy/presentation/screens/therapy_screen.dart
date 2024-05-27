import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/custom_outlined_button.dart';
import 'package:mentra/common/widgets/custom_tabbar.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/settings/data/models/question_prompt_model.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_date_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_time_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_item.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class TherapyScreen extends StatefulWidget {
  const TherapyScreen({Key? key}) : super(key: key);

  @override
  State<TherapyScreen> createState() => _TherapyScreenState();
}

class _TherapyScreenState extends State<TherapyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        centerTile: false,
        // canGoBack: false,
        leading: 0.horizontalSpace,
        leadingWidth: 0,
        height: 80,
        tittle: TextView(
          text: 'Therapy',
          style: GoogleFonts.fraunces(
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark),
        ),
        actions: [
          HapticInkWell(
            onTap: () {
              context.goNamed(PageUrl.menuScreen);
            },
            child: CircleAvatar(
              backgroundColor: Pallets.white,
              radius: 25.r,
              child: ImageWidget(
                imageUrl: Assets.images.svgs.menuIcon,
                size: 18.w,
              ),
            ),
          ),
          16.horizontalSpace,
        ],
      ),
      body: Stack(
        children: [
          const AppBg(),
          BlocBuilder<UserBloc, UserState>(
            bloc: injector.get(),
            builder: (context, state) {
              return SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                         CustomTabbar(tabs: [
                          Tab(
                            height: 60.h,

                            text: "Upcoming",
                          ),
                          Tab(
                            height: 60.h,

                            text: "History",
                          ),
                        ]),
                        40.verticalSpace,
                        const Expanded(
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                              UpcomingTherapy(),
                              TherapyHistory()
                            ])),
                        8.verticalSpace,
                        if (injector
                                .get<UserBloc>()
                                .appUser
                                ?.matchedTherapist !=
                            null)
                          Column(
                            children: [
                              CustomNeumorphicButton(
                                onTap: () {
                                  _scheduleTherapy(context);
                                },
                                fgColor: Pallets.white,
                                color: Pallets.primary,
                                text: "Schedule Session",
                                child:  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Pallets.white,
                                      size: 18.w,
                                    ),
                                    const TextView(
                                      text: 'Schedule Session',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Pallets.white),
                                    )
                                  ],
                                ),
                              ),
                              10.verticalSpace,
                              CustomOutlinedButton(
                                bgColor: Colors.white,
                                padding: const EdgeInsets.all(20),
                                outlineWidth: 1.5,
                                radius: 100,
                                outlinedColr: Pallets.primary,
                                child: const TextView(
                                  text: 'Change Therapist',
                                  fontWeight: FontWeight.w600,
                                ),
                                onPressed: () {
                                  context.pushNamed(
                                      PageUrl.userPreferenceScreen,
                                      queryParameters: {
                                        PathParam.userPreferenceFlow:
                                            UserPreferenceFlow
                                                .changeTherapist.name,
                                        PathParam.chatIntent:
                                            TherapyPreferenceIntent
                                                .changeTherapist.name,
                                      });
                                },
                              )
                            ],
                          ),
                        if (injector
                                .get<UserBloc>()
                                .appUser
                                ?.matchedTherapist ==
                            null)
                          CustomNeumorphicButton(
                            onTap: () {
                              context.pushNamed(PageUrl.userPreferenceScreen,
                                  queryParameters: {
                                    PathParam.userPreferenceFlow:
                                        UserPreferenceFlow.changeTherapist.name,
                                    PathParam.chatIntent:
                                        TherapyPreferenceIntent
                                            .changeTherapist.name,
                                  });
                            },
                            fgColor: Pallets.white,
                            color: Pallets.primary,
                            text: "Select therapist",
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextView(
                                  text: 'Select therapist',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Pallets.white),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _scheduleTherapy(BuildContext context) {
    injector.get<TherapyBloc>().currentSessionFlow = SessionFlow.schedule;
    CustomDialogs.showCupertinoBottomSheet(context, SelectDateSheet(
      onSelected: (DateTime selectedDate) {
        injector.get<TherapyBloc>().updatePayload(date: selectedDate);

        CustomDialogs.showCupertinoBottomSheet(
            context,
            SelectTimeSheet(
              date: selectedDate,
            ));
      },
    ));
  }
}

class UpcomingTherapy extends StatefulWidget {
  const UpcomingTherapy({super.key});

  @override
  State<UpcomingTherapy> createState() => _UpcomingTherapyState();
}

class _UpcomingTherapyState extends State<UpcomingTherapy>
    with AutomaticKeepAliveClientMixin {
  final TherapyBloc therapyBloc = TherapyBloc(injector.get());

  @override
  void initState() {
    _getUpcomingTherapy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<TherapyBloc, TherapyState>(
      bloc: injector.get<TherapyBloc>(),
      buildWhen: _buildWhen,
      listener: _listenToTherapyBloc,
      builder: (context, state) {
        if (state is GetUpcomingSessionsLoadingState) {
          return Center(
            child: CustomDialogs.getLoading(
              size: 50,
            ),
          );
        }

        if (state is GetUpcomingSessionsFailureState) {
          return AppPromptWidget(
            textColor: Pallets.navy,
            retryTextColor: Pallets.navy,
            onTap: () {
              injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
            },
          );
        }

        // if (state is GetUpcomingSessionsSuccessState) {
        if (injector.get<TherapyBloc>().upComingSessions.isNotEmpty ?? false) {
          var sessions = injector.get<TherapyBloc>().upComingSessions;
          return RefreshIndicator(
              onRefresh: () async {
                injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
              },
              child: AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sessions.length ?? 0,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      horizontalOffset: 60.0,
                      child: FadeInAnimation(
                        duration: const Duration(milliseconds: 600),
                        child: Padding(
                          padding:  EdgeInsets.only(bottom: 10.0.h),
                          child: TherapyItem(
                            session: sessions[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  16.verticalSpace,
                  const AppEmptyState(
                    hasBg: false,
                    tittle: 'No upcoming session.',
                    subtittle:
                        "You have no upcoming sessions. Start by booking a session with a therapist",
                  ),
                ],
              ),
            ),
          );
        }
        // }

        return Container();
      },
    );
  }

  void _listenToTherapyBloc(BuildContext context, TherapyState state) {}

  bool _buildWhen(TherapyState previous, TherapyState current) =>
      current is GetUpcomingSessionsLoadingState ||
      current is GetUpcomingSessionsSuccessState ||
      current is GetUpcomingSessionsFailureState;

  @override
  bool get wantKeepAlive => true;

  void _getUpcomingTherapy() {
    if (injector.get<TherapyBloc>().upComingSessions == null) {
      injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
    }
  }
}

class TherapyHistory extends StatefulWidget {
  const TherapyHistory({super.key});

  @override
  State<TherapyHistory> createState() => _TherapyHistoryState();
}

class _TherapyHistoryState extends State<TherapyHistory>
    with AutomaticKeepAliveClientMixin {
  // final TherapyBloc therapyBloc = TherapyBloc(injector.get());

  @override
  void initState() {
    _getSessionHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<TherapyBloc, TherapyState>(
      bloc: injector.get<TherapyBloc>(),
      listener: _listenToTherapyBloc,
      buildWhen: _buildWhen,
      builder: (context, state) {
        if (state is GetSessionsHistoryLoadingState) {
          return Center(
            child: CustomDialogs.getLoading(
              size: 50,
            ),
          );
        }

        if (state is GetSessionsHistoryFailureState) {
          return AppPromptWidget(
            textColor: Pallets.navy,
            retryTextColor: Pallets.navy,
            title: state.error,
            onTap: () {
              injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
            },
          );
        }

        // if (state is GetSessionsHistorySuccessState) {
        if (injector.get<TherapyBloc>().sessionsHistory?.isNotEmpty ?? false) {
          var sessions = injector.get<TherapyBloc>().sessionsHistory;

          return RefreshIndicator(
            onRefresh: () async {
              injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: sessions?.length ?? 0,
              padding: EdgeInsets.zero,

              // padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => TherapyItem(
                session: sessions![index],
                isUpcoming: false,
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
            },
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  16.verticalSpace,
                  const AppEmptyState(
                    hasBg: false,
                    tittle: 'No session history.',
                    subtittle:
                        "You have no previous session history. Start by booking a session with a therapist",
                  ),
                ],
              ),
            ),
          );
          // }
        }

        return Container();
      },
    );
  }

  void _listenToTherapyBloc(BuildContext context, TherapyState state) {}

  @override
  bool get wantKeepAlive => true;

  bool _buildWhen(TherapyState previous, TherapyState current) =>
      current is GetSessionsHistoryLoadingState ||
      current is GetSessionsHistorySuccessState ||
      current is GetSessionsHistoryFailureState;

  void _getSessionHistory() {
    if (injector.get<TherapyBloc>().sessionsHistory == null) {
      injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
    }
  }
}
