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

    final DateFormat formatter = DateFormat('MMMM d,  kk:mm a');
    final String formatted = formatter.format(now);

    return formatted;
  }


  static String formatOpertionsDateWithoutTime(String? date,) {
    final now = DateTime.parse(date ?? DateTime.now().toString());


    final DateFormat formatter = DateFormat('MMMM d, yyyy');
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

  static String formatFromDate(DateTime date) {
    final formatter = DateFormat('MMMM d,  y'); // Customize format as needed
    return formatter.format(date);
  }

  static String formatToFullDate(DateTime dateTime) {
    return DateFormat('EEEE, dd MMMM yyyy').format(dateTime);
  }

  static String formartToDayTime(DateTime dateTime) {
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
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String formDateTimeForJournal(DateTime dateTime) {
    // Format the date part
    String formattedDate =
        "${_getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}";

    // Format the time part
    String formattedTime = _formatTime(dateTime.hour, dateTime.minute);

    // Combine the date and time parts
    return "$formattedDate - $formattedTime";
  }

  static String _getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  static String _formatTime(int hour, int minute) {
    String period = (hour >= 12) ? "PM" : "AM";
    int formattedHour = (hour > 12) ? hour - 12 : hour;
    String formattedMinute = (minute < 10) ? "0$minute" : minute.toString();
    return "$formattedHour:$formattedMinute $period";
  }

// String formatDateString(String dateString) {
//   DateTime dateTime = DateTime.parse(dateString);
//   DateTime now = DateTime.now();
//
//   if (isThisWeek(dateTime, now)) {
//     return 'This ${formatDay(dateTime)}, ${formatMonth(dateTime)} ${dateTime.day}, ${dateTime.year}';
//   } else {
//     return '${formatDay(dateTime)}, ${formatMonth(dateTime)} ${dateTime.day}, ${dateTime.year}';
//   }
// }
//
// String formatDay(DateTime dateTime) {
//   return DateFormat('EEEE').format(dateTime);
// }
//
// String formatMonth(DateTime dateTime) {
//   return DateFormat('MMMM').format(dateTime);
// }
//
// bool isThisWeek(DateTime date, DateTime now) {
//   int daysUntilTarget = date.difference(now).inDays;
//
//   // Check if the date is within the same week (next 6 days including today)
//   return daysUntilTarget >= 0 && daysUntilTarget < 7;
// }
//
}
