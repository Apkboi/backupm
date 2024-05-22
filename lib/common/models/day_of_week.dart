class DayOfWeek {
  final String fullDay;
  final String abbreviation;

  const DayOfWeek(this.fullDay, this.abbreviation);
  bool isAfter(DayOfWeek other) {
    // Enumerate weekdays in a specific order (e.g., SUN -> MON -> ...)
    const List<DayOfWeek> weekOrder = [
      DayOfWeek('Sunday', 'SUN'),
      DayOfWeek('Monday', 'MON'),
      DayOfWeek('Tuesday', 'TUE'),
      DayOfWeek('Wednesday', 'WED'),
      DayOfWeek('Thursday', 'THU'),
      DayOfWeek('Friday', 'FRI'),
      DayOfWeek('Saturday', 'SAT'),
    ];

    int thisIndex = weekOrder.indexOf(this);
    int otherIndex = weekOrder.indexOf(other);

    // Handle cases where the current day comes before the other day in the week
    if (thisIndex < otherIndex) {
      return true;
    } else if (thisIndex > otherIndex) {
      return false;
    } else {
      // Handle same day case (consider time of day if needed)
      // You can throw an exception or return false depending on your logic
      throw Exception('Same day comparison. Consider time of day if necessary.');
    }
  }
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
