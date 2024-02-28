import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/settings/presentation/blocs/user_preference/user_preference_cubit.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_bloc.dart';
import 'package:mentra/features/therapy/presentation/bloc/therapy/therapy_event.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_date_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/select_time_sheet.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_item.dart';
import 'package:mentra/gen/assets.gen.dart';

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
        tittle: TextView(
          text: 'Therapy',
          style: GoogleFonts.fraunces(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Pallets.primaryDark),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.goNamed(PageUrl.menuScreen);
            },
            child: CircleAvatar(
              backgroundColor: Pallets.white,
              radius: 25,
              child: ImageWidget(imageUrl: Assets.images.svgs.menuIcon),
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
                        const CustomTabbar(tabs: [
                          Tab(
                            text: "Upcoming",
                          ),
                          Tab(
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
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Pallets.white,
                                      size: 18,
                                    ),
                                    TextView(
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
                                  context
                                      .pushNamed(PageUrl.changeTherapistScreen);
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
                                        UserPreferenceFlow.selectTherapist.name
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
    injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
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

        if (state is GetUpcomingSessionsSuccessState) {
          if (state.response.data.data.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                injector.get<TherapyBloc>().add(GetUpcomingSessionsEvent());
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.data.data.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => TherapyItem(
                  session: state.response.data.data[index],
                ),
              ),
            );
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
        }

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
    injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
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

        if (state is GetSessionsHistorySuccessState) {
          if (state.response.data.data.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                injector.get<TherapyBloc>().add(GetSessionHistoryEvent());
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.response.data.data.length,
                padding: EdgeInsets.zero,

                // padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) => TherapyItem(
                  session: state.response.data.data[index],
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
          }
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
}
