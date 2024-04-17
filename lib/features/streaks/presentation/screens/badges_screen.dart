import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mentra/features/streaks/presentation/bloc/daily_streak_bloc.dart';
import 'package:mentra/features/tasks/presentation/widget/badge_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {

  @override
  void initState() {
    injector.get<DailyStreakBloc>().add(GetDailyStreakEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'Badges',
                  style: GoogleFonts.fraunces(
                      fontSize: 30.sp, fontWeight: FontWeight.w600),
                ),
                25.verticalSpace,
                Expanded(
                    child: BlocConsumer<DailyStreakBloc, DailyStreakState>(
                  // buildWhen: _buildWhen,
                  bloc: injector.get<DailyStreakBloc>(),
                  listener: _listenToStreaksBloc,
                  // bloc: injector.get<NotificationsBloc>(),
                  builder: (context, state) {
                    if (state is GetStreaksLoadingState) {
                      return Center(
                        child: CustomDialogs.getLoading(size: 30),
                      );
                    }

                    if (state is GetStreaksFailureState) {
                      return Center(
                        child: AppPromptWidget(
                          onTap: () {
                            injector
                                .get<DailyStreakBloc>()
                                .add(GetDailyStreakEvent());
                          },
                        ),
                      );
                    }

                    if (state is GetStreaksSuccessState) {
                      if (state.response.data.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            injector
                                .get<DailyStreakBloc>()
                                .add(GetDailyStreakEvent());
                          },
                          child: GridView.builder(
                            itemCount: state.response.data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return BadgeItem(
                                streak: state.response.data[index],
                                fadeOut: state.response
                                    .shouldFadeOut(state.response.data[index]),
                              );
                            },
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            injector
                                .get<DailyStreakBloc>()
                                .add(GetDailyStreakEvent());
                          },
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                AppEmptyState(
                                  hasBg: false,
                                  tittle: 'No badged here',
                                  subtittle: '',
                                  tittleColor: Pallets.black,
                                  image: Assets.images.pngs.journalNote.path,
                                ),
                                // Spacer(),
                              ],
                            ),
                          ),
                        );
                      }
                    }

                    return Container();
                  },
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }

  _delete() {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are you sure you want to delete this journal entry?',
          confirmText: "Yes, I understand. Delete it",
          subtittle:
              "Deleting this entry will permanently remove it from your journal. You won't be able to recover it. Are you sure you want to proceed?",
          onConfirm: () {
            context.pop();
            CustomDialogs.showBottomSheet(
                context,
                SuccessDialog(
                  tittle: "Journal Entry has been successfully deleted.",
                  onClose: () {
                    context.pop();
                  },
                ));
          },
          onCancel: () {},
        ));
  }

  // bool _buildWhen(NotificationsState previous, NotificationsState current) {}

  void _listenToStreaksBloc(BuildContext context, DailyStreakState state) {}

  bool _buildWhen(NotificationsState previous, NotificationsState current) {
    return current is GetNotificationsLoadingState ||
        current is GetNotificationsFailureState ||
        current is GetNotificationsSuccessState;
  }
}
