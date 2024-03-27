import 'dart:ui';

import 'get_current_sessions_response.dart';

enum SendingState { loading, failed, success }

class MentraChatModel {
  final String content;
  final bool isMentraMessage;
  final bool isTyping;
  SendingState? sendingState;
  DateTime? time;

  MentraChatModel(
      {required this.content,
      this.isTyping = false,
      required this.isMentraMessage,
      this.sendingState,
      this.time});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MentraChatModel &&
        other.content == content &&
        other.isMentraMessage == isMentraMessage &&
        other.sendingState == sendingState &&
        other.time == time;
  }

  @override
  int get hashCode => hashList([content, isMentraMessage, sendingState, time]);

  factory MentraChatModel.fromPrompt(String prompt) => MentraChatModel(
      content: prompt,
      isMentraMessage: false,
      sendingState: SendingState.loading,
      time: DateTime.now());

  factory MentraChatModel.fromResponse(AiMessage message) => MentraChatModel(
      content: message.prompt,
      isMentraMessage: message.user == "assistant",
      sendingState: SendingState.success,
      time: message.createdAt.toLocal());

  factory MentraChatModel.typing() => MentraChatModel(
      content: '',
      isMentraMessage: true,
      isTyping: true,
      sendingState: SendingState.success,
      time: DateTime.now());

  factory MentraChatModel.failed() => MentraChatModel(
      content: 'Failed message test',
      isMentraMessage: false,
      isTyping: false,
      sendingState: SendingState.failed,
      time: DateTime.now());
}
