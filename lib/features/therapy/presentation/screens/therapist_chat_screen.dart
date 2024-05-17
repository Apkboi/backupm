import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/filled_textfield.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';
import 'package:mentra/features/therapy/data/models/upcoming_sessions_response.dart';
import 'package:mentra/features/therapy/presentation/bloc/session/session_chat_bloc.dart';
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
    required this.therapist,
  });

  final SessionTherapist therapist;

  @override
  State<TherapistChatScreen> createState() => _TherapistChatScreenState();
}

class _TherapistChatScreenState extends State<TherapistChatScreen> {
  final controller = TextEditingController();

  final SessionChatBloc bloc = SessionChatBloc(injector.get());

  @override
  void initState() {
    // _listenForMessages();
    bloc.add(GetMessagesEvent(widget.therapist.user.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionChatBloc, SessionChatState>(
      bloc: bloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var allMessages = bloc.messages;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            // canGoBack: false,
            // leading: 0.horizontalSpace,
            tittleText: widget.therapist.user.name,
            actions: [
              ImageWidget(
                imageUrl: widget.therapist.user.avatar,
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
                    75.verticalSpace,
                    Expanded(child: Builder(builder: (context) {
                      if (state is GetMessagesLoadingState) {
                        return Center(
                          child: CustomDialogs.getLoading(size: 30),
                        );
                      }

                      if (state is GetMessagesFailedState) {
                        return Center(
                          child: AppPromptWidget(
                            message: state.error,
                            onTap: () {
                              bloc.add(GetMessagesEvent(widget.therapist.user.id.toString()));

                            },
                          ),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        itemCount: allMessages.length,
                        itemBuilder: (context, index) => BlocProvider.value(
                          value: bloc,
                          child: TherapyMessageBox(
                            message: allMessages.toList()[index],
                            showSenderImage: _shouldShowImage(
                                allMessages, allMessages[index]),
                          ),
                        ),
                      );
                    })),
                    Row(
                      children: [
                        Expanded(
                            child: FilledTextField(
                                hasBorder: false,
                                hasElevation: false,
                                controller: controller,
                                suffix: HapticInkWell(
                                  onTap: () {
                                    sendMessage(controller.text);
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
      },
    );
  }

  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      bloc.add(SendMessageEvent(TherapyChatMessage.newUserMessage(
          message: message, receiverId: widget.therapist.user.id.toString())));
      controller.clear();
    }
  }

  bool _shouldShowImage(
      List<TherapyChatMessage> messages, TherapyChatMessage currentMessage) {
    if (messages.first.id == currentMessage.id) {
      return true;
    }

    // Check for empty list or first message
    if (messages.isEmpty || messages.indexOf(currentMessage) == 0) {
      return false;
    }

    final int currentIndex = messages.indexOf(currentMessage);
    final TherapyChatMessage previousMessage = messages[currentIndex - 1];

    return (currentMessage.id == messages.first.id) ||
        (!(previousMessage.isTherapist && currentMessage.isTherapist));
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
