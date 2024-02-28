import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/neumorphic_button.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/notification/presentation/widget/notification_item.dart';
import 'package:mentra/gen/assets.gen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final TextEditingController _noteController = TextEditingController();

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
                    child: ListView.builder(
                  itemBuilder: (context, index) => const NotificationItem(),
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
}
