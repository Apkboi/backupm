import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/library/presentation/widgets/article_notification_detail.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/ai_review_sheet.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/notification/data/models/get_notifications_response.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key, required this.notification});

  final MentraNotification notification;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: () {
        // logger.w(widget.notification.type);
        _handleNotificationClick(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Pallets.eggShell, borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.notification.readAt == null)
                    const CircleAvatar(
                      radius: 6,
                      backgroundColor: Pallets.red,
                    ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Expanded(
                              child: TextView(
                                text: widget.notification.title,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            10.horizontalSpace,
                            TextView(
                              text:
                                  timeago.format(widget.notification.createdAt),
                              color: Pallets.grey,
                            )
                          ],
                        ),
                        6.verticalSpace,
                        TextView(
                          text: widget.notification.message,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Pallets.black80,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // const Divider(
            //   thickness: 1,
            //   color: Pallets.gold,
            // )
          ],
        ),
      ),
    );
  }

  void markAsRead() {
    widget.notification.readAt = DateTime.now();
    setState(() {});
    logger.i(widget.notification.type);
    injector
        .get<NotificationsBloc>()
        .add(ReadNotificationEvent(id: widget.notification.id));
  }

  Future<void> _handleNotificationClick(BuildContext context) async {
    switch (widget.notification.type) {
      case 'session':
        markAsRead();
        context.pushNamed(PageUrl.therapyScreen);
        break;
      case 'badge':
        markAsRead();
        context.pushNamed(PageUrl.badgesScreen);
        break;
      case "welness_course":
        // context.pop();
        markAsRead();

        CustomDialogs.showCupertinoBottomSheet(
            context,
            ArticleNotificationDetailsSheet(
              notification: widget.notification,
            ));
      case 'ai_session':
        if (widget.notification.readAt == null) {
          var reviewed = await CustomDialogs.showCustomDialog(
            AiReviewSheet(
                sessionId: widget.notification.dataId.toString() ?? '1'),
            context,
          );
          if (reviewed ?? false) {
            markAsRead();
          }
        }

        break;
    }
  }
}
