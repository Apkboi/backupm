import 'dart:async';
import 'dart:isolate';

class IsolateService {
  static Future<dynamic> runTask(dynamic Function() task,
      [dynamic arguments]) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);

    final subscription = receivePort.listen((data) async {
      if (data is List) {
        final task = data[0] as Function;
        final arguments = data[1];
        final completer = data[2] as SendPort;

        final result = await task(arguments);
        completer.send(result);
      } else if (data is SendPort) {
        // Store the isolate's SendPort for future communication (optional)
      }
    });

    final result = await receivePort
        .firstWhere((data) => data != null); // Wait for data from the isolate

    isolate.kill(priority: 0);
    subscription
        .cancel(); // Cancel the subscription after receiving the response
    return result;
  }

  static void _isolateEntry(SendPort isolateSendPort) async {
    final receivePort = ReceivePort();
    isolateSendPort.send(receivePort.sendPort);

    receivePort.listen((port) async {
      final data = port as List;
      final task = data[0] as Function;
      final arguments = data[1];
      final completer = data[2] as SendPort;

      final result = await task(arguments);
      completer.send(result);
    });
  }
}
