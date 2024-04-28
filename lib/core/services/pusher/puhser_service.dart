// import 'package:pusher_client/pusher_client.dart';
//
// class PusherService {
//   PusherService._();
//
//   static PusherClient? pusher;
//
//   // / [PusherService] factory constructor.
//   static Future<PusherService> get getInstance async {
//
//     final PusherService pusherService = PusherService._();
//     return pusherService;
//
//   }
//
//   Future<void> initialize() async {
//     // var token = await StorageHelper.getString(StorageKeys.token);
//     var token = '';
//
//     PusherOptions options = PusherOptions(
//         cluster: "eu",
//         auth: PusherAuth('AuthorizationEndpoints.pusherAuth', headers: {
//           'Authorization': 'Bearer $token' ?? '',
//         }));
//
//     pusher = PusherClient("f5f24299f5d6e2354ecf", options,
//         autoConnect: true, enableLogging: true);
//     // connect at a later time than at instantiation.
//     await pusher?.connect();
//     pusher?.onConnectionStateChange((state) {
//       // AppUtils.showCustomToast(("error: ${state?.currentState}"));
//
//       print(
//           "previousState: ${state?.previousState}, currentState: ${state?.currentState}");
//     });
//
//     pusher?.onConnectionError((error) {
//       // AppUtils.showCustomToast(("error: ${error?.exception}"));
//       print("error: ${error?.message}");
//     });
//   }
//
//   Future<PusherClient?> get getClient async {
//     if (pusher == null) {
//       await initialize();
//     }
//     return pusher;
//   }
// }
