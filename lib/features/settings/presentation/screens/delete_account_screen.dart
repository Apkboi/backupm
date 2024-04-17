import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/confirm_sheet.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/success_dialog.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/services/data/session_manager.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';
import 'package:mentra/features/settings/presentation/widgets/delete_account_reason.dart';
import 'package:mentra/features/settings/presentation/widgets/settings_listtile.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final SettingsBloc _bloc = SettingsBloc(injector.get());

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
          BlocConsumer<SettingsBloc, SettingsState>(
              bloc: _bloc,
              builder: (context, state) {
                return Padding(
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
                );
              },
              listener: _listenToSettingsBloc),
        ],
      ),
    );
  }

  void _deleteAccountData() {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are You Sure You Want to Delete Your Account Data?',
          confirmText: "Yes, Delete It!",
          subtittle:
              "Deleting your account data will permanently erase all your personalized information. This includes therapy history, preferences, and saved content. Are you certain?",
          onConfirm: () async {
            _bloc.add(EraseDataEvent());
            // context.pop();
          },
          onCancel: () {},
        ));
  }

  _deleteAccount() {
    CustomDialogs.showBottomSheet(
        context,
        ConfirmSheet(
          tittle: 'Are You Sure You Want to Delete Your Account?',
          cancelText: 'No, Keep It',
          confirmText: "Yes, I Understand. Delete It",
          subtittle:
              "Deleting your account will permanently remove all your data, including therapy history, preferences, and account information. This action cannot be undone. Are you absolutely sure?",
          onConfirm: () async {
            context.pop();
            final reason = await CustomDialogs.showBottomSheet(
                context,
                DeleteAccountReason(
                  onDelete: () async {},
                ));
            if (reason != null) {
              _bloc.add(DeleteAccountEvent(reason));
            }
          },
          onCancel: () {},
        ));
  }

  void _listenToSettingsBloc(BuildContext context, Object? state) async {
    if (state is EraseDataLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is EraseDataFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is EraseDataSuccessState) {
      SessionManager().logOut();
      context.pop();
      await CustomDialogs.showBottomSheet(
          context,
          SuccessDialog(
            tittle:
                "Account data deleted successfully. Log in and you'll start fresh. Take care!",
            onClose: () {
              context.goNamed(PageUrl.onBoardingPage);
            },
          ));
      // Closing screen back to Settings
      context.goNamed(PageUrl.onBoardingPage);
    }

    if (state is DeleteAccountLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is DeleteAccountFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
    if (state is DeleteAccountSuccessState) {
      context.pop();
      SessionManager().logOut();
      await CustomDialogs.showBottomSheet(
          context,
          SuccessDialog(
            tittle:
                "Account deleted successfully. We appreciate your time with us and your valuable feedback.\n \n If you ever decide to return, we'll be here. Take care!",
            onClose: () {
              context.goNamed(PageUrl.onBoardingPage);
            },
          ));

      context.goNamed(PageUrl.onBoardingPage);
    }
  }
}
