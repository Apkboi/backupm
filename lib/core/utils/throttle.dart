import 'package:flutter/foundation.dart';

class Throttle {
  final Duration duration;
  DateTime? _lastCallTime;

  Throttle(this.duration);

  void call(VoidCallback callback) {
    final now = DateTime.now();
    if (_lastCallTime == null || now.difference(_lastCallTime!) > duration) {
      callback();
      _lastCallTime = now;
    }
  }
}
