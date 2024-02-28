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
import 'package:mentra/gen/assets.gen.dart';

class CreateJournalScreen extends StatefulWidget {
  const CreateJournalScreen({super.key});

  @override
  State<CreateJournalScreen> createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        tittleText: '',
        actions: [
          CustomNeumorphicButton(
            onTap: () {
              _delete();
              // if (selectedImageId == null) {
            },
            color: Pallets.primary,
            expanded: false,
            padding: const EdgeInsets.all(12),
            text: 'Save',
          )
        ],
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Pallets.promptMilkCOlor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text:
                            'Explore a hobby or activity that brings you joy. Why do you enjoy it?',
                        fontWeight: FontWeight.w600,
                        color: Pallets.promptDarkMilkColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FilledTextField(
                    hint: 'Write your notes here...',
                    fillColor: Colors.transparent,
                    controller: _noteController,
                    hasBorder: false,
                    maxLine: 100,
                  ),
                )
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
