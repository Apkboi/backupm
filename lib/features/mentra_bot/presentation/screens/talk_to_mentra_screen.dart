import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/end_session_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/feedback_success_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/review_sheet.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/session_ended_dialog.dart';
import 'package:mentra/features/mentra_bot/presentation/widget/talk_to_mentra_message_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class TalkToMentraScreen extends StatefulWidget {
  const TalkToMentraScreen({Key? key}) : super(key: key);

  @override
  State<TalkToMentraScreen> createState() => _TalkToMentraScreenState();
}

class _TalkToMentraScreenState extends State<TalkToMentraScreen> {
  final List<String> messages = [
    'Hey Leila! I\'m Mentra, your friendly mental health buddy. ',
    "How's your day going?",
    "Hi, Mentra! It's been a bit rough lately. Can you lend an ear?",
    "Absolutely! I'm here to listen and help. What's been bothering you?"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        // canGoBack: false,
        leading: 0.horizontalSpace,
        tittleText: 'Talk to Mentra',
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) => TalkToMentraMessageBox(
                    message: [messages[index]],
                    isSender: !index.isEven,
                  ),
                )),
                const _InputBar()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _endSession(context);
          },
          child: const CircleAvatar(
            backgroundColor: Pallets.white,
            radius: 24,
            child: Icon(
              Icons.close,
              color: Pallets.red,
            ),
          ),
        ),
        10.horizontalSpace,
        Expanded(
            child: FilledTextField(
                hasBorder: false,
                hasElevation: false,
                suffix: ImageWidget(
                  imageUrl: Assets.images.svgs.share,
                  height: 20,
                  width: 20,
                ),
                fillColor: Pallets.white,
                contentPadding: const EdgeInsets.all(16),
                radius: 45,
                hint: 'Message'))
      ],
    );
  }

  void _endSession(BuildContext context) async {
    final bool? sessionEnded =
        await CustomDialogs.showBottomSheet(context, const EndSessionDialog(),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            constraints: BoxConstraints(maxHeight: 0.9.sh));

    if (sessionEnded ?? false) {
      final bool? writeReview = await CustomDialogs.showBottomSheet(
          context, const SessionEndedDialog(),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          constraints: BoxConstraints(maxHeight: 0.9.sh));

      if (writeReview ?? false) {
        final bool? wroteFeedback =
            await CustomDialogs.showBottomSheet(context, const ReviewSheet(),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
                constraints: BoxConstraints(maxHeight: 0.9.sh));

        if (wroteFeedback ?? false) {
          await CustomDialogs.showBottomSheet(
              context, const FeedbackSuccessDialog(),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
              constraints: BoxConstraints(maxHeight: 0.9.sh));
          context.pop();
        }
        context.pop();
      } else {
        context.pop();
      }
    }
  }
}
