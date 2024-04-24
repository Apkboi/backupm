import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';

class PayHelper {
  PayHelper._internal();

  static final PayHelper instance = PayHelper._internal();

  factory PayHelper() {
    return instance;
  }

  final _paymentItems = [
    const PaymentItem(
        label: 'Total',
        amount: '100',
        status: PaymentItemStatus.final_price,
        type: PaymentItemType.total),
    const PaymentItem(
        label: 'Total2',
        amount: '100',
        status: PaymentItemStatus.final_price,
        type: PaymentItemType.total),
  ];

  late final Pay _payClient;

  Future<void> initialize({
    required String defaultGooglePayConfiguration,
    required String defaultApplePayConfiguration,
  }) async {
    final googlePayConfig =
        PaymentConfiguration.fromJsonString(defaultGooglePayConfiguration);
    final applePayConfig =
        PaymentConfiguration.fromJsonString(defaultApplePayConfiguration);
    _payClient = Pay({
      PayProvider.google_pay: googlePayConfig,
      PayProvider.apple_pay: applePayConfig,
    });
    await checkPaymentAvailability();
  }

  Future<void> checkPaymentAvailability() async {
    // final availablePaymentNetworks = await PaymentNetworks.availablePaymentNetworks;
    // if (availablePaymentNetworks.isEmpty) {
    //   // Handle no payment networks available scenario (e.g., display message)
    //   debugPrint('No payment networks available');
    // }
  }

  Future<Map<String, dynamic>> requestPayment(
      PayProvider provider, List<PaymentItem> paymentItems) async {
    try {
      final result =
          await _payClient.showPaymentSelector(provider, _paymentItems);
      return result;
    } on PlatformException catch (error) {
      // Handle platform errors (e.g., payment cancelled, network issues)
      debugPrint(error.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> requestGooglePayPayment(
      List<PaymentItem> paymentItems) async {
    return await requestPayment(PayProvider.google_pay, paymentItems);
  }

  Future requestApplePayPayment(List<PaymentItem> paymentItems) async {
    return await requestPayment(PayProvider.apple_pay, paymentItems);
  }
}
