import 'package:mentra/common/models/day_of_week.dart';

extension DateTimeExtensio on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  String get toCustomString =>
      " ${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
}

extension DayOfWeekExtension on DateTime {
  DayOfWeek get dayOfWeek {
    switch (weekday) {
      case DateTime.monday:
        return const DayOfWeek('Monday', 'MON');
      case DateTime.tuesday:
        return const DayOfWeek('Tuesday', 'TUE');
      case DateTime.wednesday:
        return const DayOfWeek('Wednesday', 'WED');
      case DateTime.thursday:
        return const DayOfWeek('Thursday', 'THU');
      case DateTime.friday:
        return const DayOfWeek('Friday', 'FRI');
      case DateTime.saturday:
        return const DayOfWeek('Saturday', 'SAT');
      case DateTime.sunday:
        return const DayOfWeek('Sunday', 'SUN');
      default:
        throw Exception('Unexpected weekday value');
    }
  }
}
