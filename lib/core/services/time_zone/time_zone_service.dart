import 'package:flutter_timezone/flutter_timezone.dart';

class TimezoneService {
  static final TimezoneService _instance = TimezoneService._internal();

  factory TimezoneService() {
    return _instance;
  }

  TimezoneService._internal();

  dynamic _currentTimezone;

  Future<void> init() async {
    _currentTimezone = await getCurrentTimeZone();
  }

  /// Gets the current timezone location identifier,
  /// after calling the init function.
  String get currentTimeZone {
    if (_currentTimezone == null) {
      return 'Asia/Dubai';
    }
    return _currentTimezone;
  }

  // Other methods from previous version (getTimezoneAbbreviation, etc.)

  Future<String> getCurrentTimeZone() async {
    final String timezone = await FlutterTimezone.getLocalTimezone();
    return timezone;
  }

// ... other methods ...
}
