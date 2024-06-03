import 'package:mentra/core/_core.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/therapy/data/models/therapy_chat_message.dart';

extension TherapyMessageExtension on List<TherapyChatMessage> {
  List<TherapyChatMessage> formatChatListWithDividers() {
    final formattedList = <TherapyChatMessage>[];
    var previousDate = DateTime(1970); // Initialize with a far past date
    if (isNotEmpty) {
      for (final message in reversed) {
        final isSameDay = TimeUtil.isSameDate(previousDate, message.time);
        logger.w("$isSameDay${message.message}");
        final formattedDate = TimeUtil.formatMessageDate(message.time);
        if (!isSameDay && first != message) {
          formattedList.add(TherapyChatMessage.divider(message: formattedDate));
          previousDate = message.time;
        }
        formattedList.add(message);
      }
    }

    return formattedList.reversed.toList();
  }
}
