import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/features/subscription/data/models/get_plans_response.dart';
import 'package:mentra/features/subscription/data/models/subscribe_response.dart';
import 'package:mentra/features/subscription/data/models/subscription_payload.dart';
import 'package:mentra/features/subscription/dormain/repository/subscription_repository.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;

  SubscriptionBloc(this.subscriptionRepository) : super(SubscriptionInitial()) {
    on<SubscriptionEvent>((event, emit) {});
    on<GetPlansEvent>(_mapGetPlansEventToState);
    on<SubscribeEvent>(_mapSubscribeEventToState);
  }

  FutureOr<void> _mapGetPlansEventToState(
      GetPlansEvent event, Emitter<SubscriptionState> emit) async {
    emit(GetPlansLoadingState());
    try {
      final response = await subscriptionRepository.getPlans();
      emit(GetPlansSuccessState(response));
    } catch (e,stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetPlansFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapSubscribeEventToState(
      SubscribeEvent event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoadingState());
    try {
      final response = await subscriptionRepository.subscribe(event.payload);
      emit(SubscribeSuccessState(response));
    } catch (e) {
      logger.e(e.toString());
      emit(SubscriptionFailureState(e.toString()));
    }
  }
}
