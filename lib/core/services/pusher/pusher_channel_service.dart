import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:mentra/common/blocs/pusher/pusher_cubit.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherChannelService {
  PusherChannelService._();

  static PusherChannelsFlutter? pusher;

  // / [PusherService] factory constructor.
  static Future<PusherChannelService> get getInstance async {
    final PusherChannelService pusherService = PusherChannelService._();
    return pusherService;
  }

  Future<void> initialize() async {
    pusher = PusherChannelsFlutter.getInstance();

    try {
      await pusher?.init(
        // apiKey: '86bddfa4606d2c40e7a5',
        apiKey: '6e531aee4ab45d75d4ad',
        cluster: "mt1",

        maxReconnectGapInSeconds: 1,
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

      pusher?.onConnectionStateChange = (currentState, previousState) {
        debugPrint(
            "Pusher connection previousState: $previousState, currentState: $currentState");
        if (currentState == "DISCONNECTED") {
          pusher?.connect();
        }
      };

      pusher?.onError = (message, code, error) {
        debugPrint("Pusher Error: ${error?.message}");
      };
    }  catch (e) {

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
    (await getClient)?.unsubscribe(channelName: channelName);
  }

  _authorize(String channelName, String socketId, options) async {
    dynamic result;
    // var result = await injector.get<HttpHelper>().post(
    //   AuthorizationEndpoints.pusherAuth,
    //   body: {
    //     'socket_id': socketId,
    //     'channel_name': channelName,
    //   },
    // );
    return jsonDecode(result.data['channel_data']);
  }

// _authorize(String channelName, String socketId, options) async {
//
//   return {
//     "channel_data": '{"user_id": 1}',
//     "shared_secret": "foobar"
//   };
// }
}
