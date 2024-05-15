import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/sentory/sentory_service.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:crypto/crypto.dart';

class PusherChannelService {
  PusherChannelService._();

  static PusherChannelsFlutter? pusher;

  // / [PusherService] factory constructor.
  static Future<PusherChannelService> get getInstance async {
    final PusherChannelService pusherService = PusherChannelService._();
    return pusherService;
  }

  Future<void> initialize() async {
    var connections = await Connectivity().checkConnectivity();

    if (!connections.contains(ConnectivityResult.none)) {
      try {
        pusher = PusherChannelsFlutter.getInstance();

        await pusher?.init(
          // apiKey: '86bddfa4606d2c40e7a5',
          apiKey: '6e531aee4ab45d75d4ad',
          cluster: "mt1",

          maxReconnectGapInSeconds: 5,
          onEvent: (event) {
            injector.get<PusherCubit>().triggerPusherEvent(event);

            // logger.w(event.data);
            // AppUtils.showCustomToast(event.data.toString());
          },
          onSubscriptionError: (d, a) {
            log("onSubscriptionError: $d Exception: $a");
            // AppUtils.showCustomToast("onSubscriptionError: $d Exception: $a");
          },
          onAuthorizer: _authorize,
          // authEndpoint: AuthorizationEndpoints.pusherAuth
        );

        await pusher?.connect();

        // pusher?.onConnectionStateChange = (currentState, previousState) async {
        //   var connections = await Connectivity().checkConnectivity();
        //
        //   debugPrint(
        //       "Pusher connection previousState: $previousState, currentState: $currentState");
        //   if (currentState == "DISCONNECTED") {
        //     //
        //
        //     if (!connections.contains(ConnectivityResult.none)) {
        //       pusher?.connect();
        //     }
        //
        //     // initialize();
        //   }
        // };

        pusher?.onError = (message, code, error) {
          debugPrint("Pusher Error: ${error?.message}");
        };
      } catch (e, stackTrace) {
        logger.e(e, stackTrace: stackTrace);
        SentryService.captureException(e, stackTrace: stackTrace);
      }
    }
  }

  Future<PusherChannelsFlutter?> get getClient async {
    if (pusher == null) {
      await initialize();
    }
    return pusher;
  }

  /// Unsubscribe from a channel
  Future<void> unsubscribe(String channelName) async {
    try {
      (await getClient)?.unsubscribe(channelName: channelName);
    } catch (exception, stackTrace) {
      SentryService.captureException(exception, stackTrace: stackTrace);
    }
  }

  _authorize(String channelName, String socketId, options) async {
    return {
      "auth":
      "6e531aee4ab45d75d4ad:${getSignature(
          "$socketId:private-conversation.27")}",
    };
  }

  getSignature(String value) {
    var key = utf8.encode('a7a8a166ad27ac7b03b3');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

// _authorize(String channelName, String socketId, options) async {
//
//   return {
//     "channel_data": '{"user_id": 1}',
//     "shared_secret": "foobar"
//   };
// }
}
