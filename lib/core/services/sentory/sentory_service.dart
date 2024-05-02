import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  static Future<void> initializeApp(
    String dsn,
    FutureOr<void> Function() appRunner,
  ) async {
    // Initialize Flutter
    if (!kDebugMode) {
      FlutterError.onError = (errorDetails) async {
        await Sentry.captureException(errorDetails.exception,
            stackTrace: errorDetails.stack);
        throw errorDetails.exception; // Re-throw for further handling
      }; // Initialize Sentry
      await SentryFlutter.init((options) => options.dsn = dsn,
          appRunner: appRunner
          // debug: kDebugMode, // Set to false for release builds
          );
    } else {
      appRunner();
    }
  }

  static void captureException(exception, {StackTrace? stackTrace}) {
    Sentry.captureException(exception, stackTrace: stackTrace);
  }

  static void captureMessage(String message) {
    Sentry.captureMessage(message);
  }
}
