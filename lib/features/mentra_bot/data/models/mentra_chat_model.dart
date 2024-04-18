import 'dart:ui';

import 'package:mentra/features/mentra_bot/data/models/bot_chat_model.dart';

import 'get_current_sessions_response.dart';

enum SendingState { loading, failed, success }

class MentraChatModel {
  final int stage;
  final String content;
  final bool isMentraMessage;
  final bool isTyping;
  SendingState? sendingState;
  DateTime? time ;
  List options;

  MentraChatModel({
    this.stage = 0,
    required this.content,
    this.isTyping = false,
    required this.isMentraMessage,
    this.sendingState,
    this.options = const [],
    this.time,
  });

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
  int get hashCode =>
      hashList([content, isMentraMessage, sendingState, time, stage]);

  factory MentraChatModel.fromPrompt(String prompt) => MentraChatModel(
      content: prompt,
      isMentraMessage: false,
      sendingState: SendingState.loading,
      time: DateTime.now());

  factory MentraChatModel.fromResponse(AiMessage message) => MentraChatModel(
      content: message.prompt,
      isMentraMessage: message.user == "assistant",
      sendingState: SendingState.success,
      options: message.suggestion,
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

  factory MentraChatModel.fromBotChatMessage(BotChatmessageModel message) {
    return MentraChatModel(
      content: message.message,
      isTyping: message.isTyping ?? false,
      isMentraMessage: message.isFromBot,
      sendingState: SendingState.success,
      time: message.time,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'isMentraMessage': isMentraMessage,
      'isTyping': isTyping,
      'sendingState': sendingState?.toString(),
      // Convert SendingState to string
      'time': time?.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'options': options,
    };
  }

  Map<String, dynamic> toRequestJson() {
    return {"user": isMentraMessage ? "assistant" : "user", "prompt": content};
  }

  factory MentraChatModel.fromJson(Map<String, dynamic> json) {
    return MentraChatModel(
      content: json['content'],
      isMentraMessage: json['isMentraMessage'],
      isTyping: json['isTyping'] ?? false,
      sendingState: _parseSendingState(json['sendingState']),
      time: json['time'] != null ? DateTime.tryParse(json['time']) : null,
      options: json['options'] != null ? List.from(json['options']) : [],
    );
  }

  static SendingState? _parseSendingState(String? value) {
    switch (value) {
      case 'SendingState.loading':
        return SendingState.loading;
      case 'SendingState.failed':
        return SendingState.failed;
      case 'SendingState.success':
        return SendingState.success;
      default:
        return null;
    }
  }
}
