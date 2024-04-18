import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:mentra/features/notification/presentation/widget/notification_item.dart';
import 'package:mentra/features/therapy/presentation/widgets/therapy_empty_state.dart';
import 'package:mentra/gen/assets.gen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    injector.get<NotificationsBloc>().add(GetNotificationsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Notifications',
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                Expanded(
                    child: BlocConsumer<NotificationsBloc, NotificationsState>(
                  buildWhen: _buildWhen,
                  listener: _listenToJournalBloc,
                  bloc: injector.get<NotificationsBloc>(),
                  builder: (context, state) {
                    if (state is GetNotificationsLoadingState) {
                      return Center(
                        child: CustomDialogs.getLoading(size: 30),
                      );
                    }

                    if (state is GetNotificationsFailureState) {
                      return Center(
                        child: AppPromptWidget(
                          onTap: () {
                            injector
                                .get<NotificationsBloc>()
                                .add(GetNotificationsEvent());
                          },
                        ),
                      );
                    }

                    if (state is GetNotificationsSuccessState) {
                      if (state.response.data.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            injector
                                .get<NotificationsBloc>()
                                .add(GetNotificationsEvent());
                          },
                          child: ListView.builder(
                            itemCount: state.response.data.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: NotificationItem(
                                notification: state.response.data[index],
                                // notification: MentraNotification(
                                //     id: 'id',
                                //     title: 'This is a tittle',
                                //     message: 'message message message messagemessagemessagemessage message\nmessagemessagemessage',
                                //     type: '',
                                //     dataId: 'dataId',
                                //     readAt: DateTime.now(),
                                //     createdAt: DateTime.now()),
                                //
                                // prompt: state.response.data[index],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            injector
                                .get<NotificationsBloc>()
                                .add(GetNotificationsEvent());
                          },
                          child: Center(
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                AppEmptyState(
                                  hasBg: false,
                                  tittle: 'You have no notifications',
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

  void _listenToJournalBloc(BuildContext context, NotificationsState state) {}

  bool _buildWhen(NotificationsState previous, NotificationsState current) {
    return current is GetNotificationsLoadingState ||
        current is GetNotificationsFailureState ||
        current is GetNotificationsSuccessState;
  }
}
