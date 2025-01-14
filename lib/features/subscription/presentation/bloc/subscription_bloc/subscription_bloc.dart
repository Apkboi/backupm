import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/pay/pay_service.dart';
import 'package:mentra/core/services/stripe/stripe_service.dart';
import 'package:mentra/features/account/presentation/user_bloc/user_bloc.dart';
import 'package:mentra/features/subscription/data/models/get_plans_response.dart';
import 'package:mentra/features/subscription/data/models/stripe_subscription_payload.dart';
import 'package:mentra/features/subscription/data/models/subscription_payload.dart';
import 'package:mentra/features/subscription/dormain/repository/subscription_repository.dart';
import 'package:pay/pay.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;

  SubscriptionBloc(this.subscriptionRepository) : super(SubscriptionInitial()) {
    on<SubscriptionEvent>((event, emit) {});
    on<GetPlansEvent>(_mapGetPlansEventToState);
    on<SubscribeEvent>(_mapSubscribeEventToState);
    on<CancelSubscriptionEvent>(_mapCancelSubscriptionToState);
  }

  FutureOr<void> _mapGetPlansEventToState(
      GetPlansEvent event, Emitter<SubscriptionState> emit) async {
    emit(GetPlansLoadingState());
    try {
      final response = await subscriptionRepository.getPlans();
      emit(GetPlansSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(GetPlansFailureState(e.toString()));
    }
  }

  FutureOr<void> _mapSubscribeEventToState(
      SubscribeEvent event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoadingState());
    try {
      final paymentIntent =
          await subscriptionRepository.createPaymentIntent(event.payload);

      var paymentInfo = await makeStripePayment(StripeSubscriptionPayload(
          intent: paymentIntent,
          paymentType: PaymentType.reOcurring,
          plan: event.payload.planName,
          enablePlatformPay: true));
      // var paymentInfo = await _makePayment(event.payload);
      // var response = await onPayResult(paymentInfo, event.payload);
      injector.get<UserBloc>().add(GetRemoteUser());
      emit(SubscribeSuccessState(paymentInfo));
    } on PlatformException catch (e, stack) {
      logger.e(e.message);
      logger.e(stack.toString());
      emit(SubscriptionFailureState(e.message ?? "Something went wrong"));
    } catch (exception, stack) {
      logger.e(exception.toString());
      logger.e(stack.toString());
      emit(SubscriptionFailureState(exception.toString()));
    }
  }

  Future<Map<String, dynamic>> _makePayment(SubscriptionPayload payload) async {
    if (Platform.isAndroid) {
      var googlePayResult = await PayHelper.instance.requestGooglePayPayment([
        PaymentItem(
            label: payload.planName,
            amount: payload.amount,
            status: PaymentItemStatus.final_price,
            type: PaymentItemType.total),
      ]);
      logger.w(googlePayResult.toString());

      return googlePayResult;
      // onPayResult(googlePayResult, payload);
    } else {
      var applePay = await PayHelper.instance.requestApplePayPayment([]);
      logger.w(applePay.toString());
      return applePay;
      // onPayResult(applePay, payload);
    }
  }

  Future<dynamic> onPayResult(
      paymentResult, SubscriptionPayload payload) async {
    // final response = await StripeService().createTestPaymentSheet();
    // final clientSecret = response['client_secret'];
    // final token =
    //     paymentResult['paymentMethodData']['tokenizationData']['token'];
    // final tokenJson = Map.castFrom(json.decode(token));
    final params = PaymentMethodParams.cardFromToken(
      paymentMethodData:
          PaymentMethodDataCardFromToken.fromJson({"token": 'tok_visa'}),
    );
    return await subscriptionRepository.subscribe(payload);

    // Confirm Google pay payment method
    // var paymentIntent = await Stripe.instance.confirmPayment(
    //   data: params,
    //   paymentIntentClientSecret: clientSecret,
    // );
    // logger.w(paymentIntent.toJson());
  }

  Future makeStripePayment(StripeSubscriptionPayload payload) async {
    var response = await StripeService().initPaymentSheet(payload);
    return 'Successful';
  }

  FutureOr<void> _mapCancelSubscriptionToState(
      CancelSubscriptionEvent event, Emitter<SubscriptionState> emit) async {
    emit(CancelSubscriptionLoadingState());
    try {
      final response =
          await subscriptionRepository.cancelSubscription(event.id);
      emit(CancelSubscriptionSuccessState(response));
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack.toString());
      emit(CancelSubscriptionFailureState(e.toString()));
    }
  }
}
