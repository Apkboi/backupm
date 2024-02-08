import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/presentation/widgets/delete_account_reason.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        tittleText: 'Delete Data or Account',
      ),
      body: Stack(
        children: [
          const AppBg(),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                100.verticalSpace,
                Container(
                    decoration: BoxDecoration(
                        color: Pallets.white,
                        borderRadius: BorderRadius.circular(17)),
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Column(
                        children: [
                          SettingListTile(
                              onTap: () {
                                _deleteAccount();
                              },
                              tittle: 'Delete Account'),
                          35.verticalSpace,
                          SettingListTile(
                              onTap: () => _deleteAccountData(),
                              tittle: 'Erase Data'),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAccountData() {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are you sure you want to delete your account data?',
          confirmText: "Yes, I understand. Delete my data",
          subtittle:
              "Deleting your account data will permanently erase all your personalized information. This includes therapy history, preferences, and saved content. Are you certain?",
          onConfirm: () async {
            await CustomDialogs.showBottomSheet(
                context,
                SuccessDialog(
                  tittle:
                      "Account data deleted successfully. Log in and you'll start fresh. Take care!",
                  onClose: () {},
                ));
            // Closing screen back to Settings
            context.pop();
            context.pop();
            // context.pop();
          },
          onCancel: () {},
        ));
  }

  _deleteAccount() {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are you sure you want to delete your account?',
          confirmText: "Yes, I understand. Delete it",
          subtittle:
              "Deleting your account will permanently remove all your data, including therapy history, preferences, and account information. This action cannot be undone. Are you absolutely sure?",
          onConfirm: () {
            context.pop();
            CustomDialogs.showBottomSheet(context, DeleteAccountReason(
              onDelete: () async {
                await CustomDialogs.showBottomSheet(
                    context,
                    SuccessDialog(
                      tittle:
                          "Account deleted successfully. We appreciate your time with us and your valuable feedback.\n \n If you ever decide to return, we'll be here. Take care!",
                      onClose: () {
                        context.pop();
                      },
                    ));
                // Closing screen back to Settings
                context.pop();
                context.pop();
                // context.pop();
              },
            ));
          },
          onCancel: () {},
        ));
  }
}
