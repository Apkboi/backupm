import 'package:flutter/material.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/chat_message.dart';
import 'package:mentra/features/therapy/presentation/bloc/session/session_bloc.dart';
import 'package:mentra/features/therapy/presentation/widgets/chat/therapy_message_box.dart';
import 'package:mentra/features/therapy/presentation/widgets/join_session_button.dart';
import 'package:mentra/gen/assets.gen.dart';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

DemoUser user2 = DemoUser(
    '72907e6a689c61c1d5f1572ff97116a28dee3e911a5c673d234eee4ad2f6ja9a4a4cd39a',
    'joel@gmail.com');

class TherapistChatScreen extends StatefulWidget {
  const TherapistChatScreen({
    super.key,
  });

  @override
  State<TherapistChatScreen> createState() => _TherapistChatScreenState();
}

class _TherapistChatScreenState extends State<TherapistChatScreen> {
  final controller = TextEditingController();

  final List<String> messages = [
    'Hey Leila! I\'m Mentra, your friendly mental health buddy. ',
    "How's your day going?",
    "Hi, Mentra! It's been a bit rough lately. Can you lend an ear?",
    "Absolutely! I'm here to listen and help. What's been bothering you?"
  ];
  List<TherapyChatMessage> Allmessages = [];

  final SessionBloc bloc = SessionBloc();

  @override
  void initState() {
    // _listenForMessages();
    // bloc.add(GetMessagesEvent());
    super.initState();
  }

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
            onTap: () {
              // _endSession(context);
            },
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
                  reverse: true,
                  itemCount: Allmessages.length,
                  itemBuilder: (context, index) => TherapyMessageBox(
                    message: Allmessages.reversed.toList()[index],
                    isSender: !index.isEven,
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                        child: FilledTextField(
                            hasBorder: false,
                            hasElevation: false,
                            controller: controller,
                            suffix: HapticInkWell(
                              onTap: () {
                                sendMessage();
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
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage() async {
    controller.clear();
  }
}

class _InputBar extends StatefulWidget {
  const _InputBar({Key? key}) : super(key: key);

  @override
  State<_InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<_InputBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FilledTextField(
                hasBorder: false,
                hasElevation: false,
                controller: controller,
                suffix: HapticInkWell(
                  onTap: () {
                    sendMessage();
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
      ],
    );
  }

  Future<void> sendMessage() async {}
}
