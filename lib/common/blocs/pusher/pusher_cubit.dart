import 'package:bloc/bloc.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/pusher/pusher_channel_service.dart';
import 'package:meta/meta.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
part 'pusher_state.dart';

class PusherCubit extends Cubit<PusherState> {
  PusherCubit() : super(PusherInitial());

  void triggerPusherEvent(PusherEvent event) {
    emit(PusherEventReceivedState(event));
  }


  void subscribeToChannel(String name) async {
    var pusherService = await PusherChannelService.getInstance;
    var pusher = await pusherService.getClient;
    if (pusher != null) {
      logger.w('connecting');
      if (!pusher.channels.containsKey(name)) {
        PusherChannel channel = await pusher.subscribe(
          channelName: name,
          onSubscriptionError: (message, d) => onSubscriptionError(message, d),
          onSubscriptionSucceeded: (data) {
            // log('subscribed');
            // AppUtils.showCustomToast("onSubscriptionSucceeded:  data: $data");
            // return data;a
          },
          // onEvent: (event) => onEventReceived1(event),
        );
        logger.w('connected');
      } else {
        logger.w('connected2');

        pusher.getChannel(name)?.onEvent = onEventReceived;
      }
      await pusher.connect();
    }
  }

  onSubscriptionError(message, d) {}

  onEventReceived(event) {
    triggerPusherEvent(event);
  }

  onEventReceived1(event) {}
}
