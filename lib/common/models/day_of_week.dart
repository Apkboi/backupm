class DayOfWeek {
  final String fullDay;
  final String abbreviation;

  const DayOfWeek(this.fullDay, this.abbreviation);
}

// List of all weekdays
final List<DayOfWeek> weekdays = [
  const DayOfWeek('Monday', 'MON'),
  const DayOfWeek('Tuesday', 'TUE'),
  const DayOfWeek('Wednesday', 'WED'),
  const DayOfWeek('Thursday', 'THU'),
  const DayOfWeek('Friday', 'FRI'),
  const DayOfWeek('Saturday', 'SAT'),
  const DayOfWeek('Sunday', 'SUN'),
];
