import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/notification/presentation/widget/notification_details_screen.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomDialogs.showCupertinoBottomSheet(
            context, const NotificationDetailsSheet());
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 6,
                  backgroundColor: Pallets.red,
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: TextView(
                              text: '🎉 New Feature Alert!',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextView(
                            text: '6 days ago',
                            color: Pallets.grey,
                          )
                        ],
                      ),
                      6.verticalSpace,
                      const TextView(
                        text:
                            'Explore our latest guided meditation series to relax and recharge. Tap to start!',
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
}
