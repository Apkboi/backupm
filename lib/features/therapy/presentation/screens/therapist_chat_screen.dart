import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';

import 'package:mentra/features/therapy/presentation/widgets/chat/therapy_message_box.dart';
import 'package:mentra/gen/assets.gen.dart';

class TherapistChatScreen extends StatefulWidget {
  const TherapistChatScreen({Key? key}) : super(key: key);

  @override
  State<TherapistChatScreen> createState() => _TherapistChatScreenState();
}

class _TherapistChatScreenState extends State<TherapistChatScreen> {
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
        // leading: 0.horizontalSpace,
        tittleText: 'Nour Martin, Ph.D.',
        actions: [
          ImageWidget(
            imageUrl: Assets.images.pngs.avatar2.path,
            height: 50.h,
            fit: BoxFit.cover,
            shape: BoxShape.circle,
            width: 50.w,
          ),
          20.horizontalSpace
        ],
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
                  itemBuilder: (context, index) => TherapyMessageBox(
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
        Expanded(
            child: FilledTextField(
                hasBorder: false,
                hasElevation: false,
                // suffix: ImageWidget(
                //   imageUrl: Assets.images.svgs.share,
                //   height: 20,
                //   width: 20,
                // ),
                suffix: InkWell(
                  onTap: () {
                    // _answerQuestion(context);
                  },
                  child: const Icon(
                    Icons.send_rounded,
                    size: 30,
                  ),
                ),
                fillColor: Pallets.white,
                contentPadding: const EdgeInsets.all(16),
                radius: 45,
                hint: 'Message')),
        // 10.horizontalSpace,
        // InkWell(
        //   onTap: () {
        //     // _endSession(context);
        //   },
        //   child: CircleAvatar(
        //       backgroundColor: Pallets.white,
        //       radius: 24,
        //       child: ImageWidget(imageUrl: Assets.images.svgs.messageIcon)),
        // )
      ],
    );
  }
}
