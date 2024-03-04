import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/features/library/presentation/widgets/article_notification_detail.dart';
import 'package:mentra/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/notification/data/models/get_notifications_response.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key, required this.notification});

  final MentraNotification notification;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _handleNotificationClick(context);
      },
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
                        children: [
                          Expanded(
                            child: TextView(
                              text: widget.notification.title,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextView(
                            text: timeago.format(widget.notification.createdAt),
                            color: Pallets.grey,
                          )
                        ],
                      ),
                      6.verticalSpace,
                      TextView(
                        text: widget.notification.message,
                        color: Pallets.black80,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Pallets.gold,
          )
        ],
      ),
    );
  }

  void _handleNotificationClick(BuildContext context) {
    widget.notification.readAt = DateTime.now();
    setState(() {});
    injector
        .get<NotificationsBloc>()
        .add(ReadNotificationEvent(id: widget.notification.id));
    switch (widget.notification.type) {
      case 'session':
        context.pushNamed(PageUrl.therapyScreen);
        break;
      case "welness_course":
        // context.pop();
        CustomDialogs.showCupertinoBottomSheet(
            context,
            ArticleNotificationDetailsSheet(
              notification: widget.notification,
            ));
        break;
    }
  }
}
