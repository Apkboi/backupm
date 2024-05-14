import 'package:mentra/features/mentra_bot/data/models/mentra_chat_model.dart';
import 'package:mentra/features/therapy/data/models/send_message_response.dart';
import 'package:uuid/uuid.dart';

class TherapyChatMessage {
  String message;
  DateTime time;
  bool isTherapist;
  dynamic media;
  String id;
  String? receiverId;
  SendingState sendingState;

  TherapyChatMessage(
      {required this.message,
      required this.time,
      required this.isTherapist,
      this.sendingState = SendingState.success,
      this.media,
      this.receiverId,
      required this.id});

  factory TherapyChatMessage.fromChatMessage(ChatMessage message) {
    return TherapyChatMessage(
      message: message.message,
      time: message.createdAt,
      receiverId: message.receiverId.toString(),
      isTherapist: message.isTherapist,
      // Assuming therapist messages are mapped here
      id: message.id.toString(), // Assuming 'id' field exists in ChatMessage
    );
  }

  factory TherapyChatMessage.newUserMessage(
      {required String message, required String receiverId}) {
    return TherapyChatMessage(
      message: message,
      time: DateTime.now(),
      receiverId: receiverId,
      isTherapist: false,
      // Assuming therapist messages are mapped here
      id: const Uuid().v4(), // Assuming 'id' field exists in ChatMessage
    );
  }
}
