import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeUtil {
  /// format date
  static String formatDate(String date) {
    if (date.isEmpty) return 'N/A';
    DateTime dt = DateTime.parse(date);
    return DateFormat("MMM dd, yyyy").format(dt);
  }

  static String formatDateYYYMMDD(String date) {
    if (date.isEmpty) return 'N/A';
    DateTime dt = DateTime.parse(date);
    return DateFormat("yyyy-MM-dd").format(dt);
  }

  static String formatDateDDMMYYY(String date) {
    if (date.isEmpty) return 'N/A';
    DateTime dt = DateTime.parse(date);
    return DateFormat("dd-MM-yyyy").format(dt);
  }

  static String formatOperationsDate(String? date, int type) {
    final now = DateTime.parse(date ?? DateTime.now().toString());

    if (type == 2) {
      final DateFormat formatter = DateFormat('yyyy');
      final String formatted = formatter.format(now);

      return formatted;
    }
    if (type == 1) {
      final DateFormat formatter = DateFormat('MMMM yyyy');
      final String formatted = formatter.format(now);

      return formatted;
    }

    final DateFormat formatter = DateFormat('MMMM, d  kk:mm a');
    final String formatted = formatter.format(now);

    return formatted;
  }

  static String timeFormat(String? updatedAt) {
    if (updatedAt == null) return 'N/A';
    if (updatedAt.isEmpty) return 'N/A';

    final dt = DateTime.parse(updatedAt);
    return DateFormat('h:mm a').format(dt);
    // return DateFormat('MMMM, d  kk:mm a').format(dt);
  }

  static String _returnOngoingTime(Duration difference) {
    if (difference.inHours > 24) return 'CLOSES IN: ${difference.inDays} DAYS';
    return 'CLOSES IN: ${difference.inHours}H : ${difference.inMinutes}M : ${difference.inSeconds}S';
  }

  static String _returnUpcomingTime(Duration difference) {
    if (difference.inHours > 24) return 'OPENS IN: ${difference.inDays} DAYS';
    return 'OPENS IN: ${difference.inHours}H : ${difference.inMinutes}M : ${difference.inSeconds}S';
  }

  static String getTimeAgo(String? date) {
    if (date == null || date.isEmpty) {
      return '0';
    }
    final duration =
        DateTime.now().difference(DateTime.tryParse(date) ?? DateTime.now());
    final fifteenAgo = DateTime.now().subtract(duration);

    return timeago.format(fifteenAgo);
  }

  static String  formatFromDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }




 static  String formartToDayTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    DateTime tomorrow = now.add(const Duration(days: 1));

    if (isSameDay(dateTime, now)) {
      return 'Today, at ${formatTime(dateTime)}';
    } else if (isSameDay(dateTime, yesterday)) {
      return 'Yesterday, at ${formatTime(dateTime)}';
    } else if (isSameDay(dateTime, tomorrow)) {
      return 'Tomorrow, at ${formatTime(dateTime)}';
    } else {
      return '${formatDay(dateTime)}, at ${formatTime(dateTime)}';
    }
  }

 static String formatDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

 static String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

 static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

}
