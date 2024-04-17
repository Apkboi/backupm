import 'dart:async';
import 'dart:developer';


import 'package:flutter/foundation.dart';

///Creates a debouncer class that accepts the[int] milliseconds
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  // Disposes the timer
  void dispose() {
    _timer?.cancel();
  }
}


///A throttle class that accepts the[Duration] coolDown
class Throttle {
  final Duration coolDown;
  Timer? _timer;

  Throttle({required this.coolDown});


  run(VoidCallback action) {
    if (_timer?.isActive?? false){
      log('still running');
    }else{
      _timer = Timer(coolDown, action);

    }
  }

  // Disposes the timer
  void dispose() {
    _timer?.cancel();
  }

}