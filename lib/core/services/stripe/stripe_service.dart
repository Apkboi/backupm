import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';

class StripeService {
  static const String _publishableKey =
      'your_publishable_key'; // Replace with your own publishable key

  static Future<void> initialize() async {
    Stripe.publishableKey = UrlConfig.stripeTestKey;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
  }

  NetworkService networkService = injector.get<NetworkService>();

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createTestPaymentSheet();

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Enable custom flow
          customFlow: true,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          // Extra options
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'DE',
          ),
          googlePay: PaymentSheetGooglePay(merchantCountryCode: 'DE'),
          style: ThemeMode.dark,
        ),
      );
      // setState(() {
      //   step = 1;
      // });
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      rethrow;
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      // setState(() {
      //   step = 2;
      // });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Payment option selected'),
      //   ),
      // );
    } on Exception catch (e) {
      if (e is StripeException) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Error from Stripe: ${e.error.localizedMessage}'),
        //   ),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Unforeseen error: ${e}'),
        //   ),
        // );
      }
    }
  }

  Future<void> confirmPayment() async {
    try {
      // 4. Confirm the payment sheet.
      await Stripe.instance.confirmPaymentSheetPayment();

      // setState(() {
      //   step = 0;
      // });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Payment succesfully completed'),
      //   ),
      // );
    } on Exception catch (e) {
      if (e is StripeException) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Error from Stripe: ${e.error.localizedMessage}'),
        //   ),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Unforeseen error: ${e}'),
        //   ),
        // );
      }
    }
  }

  Future<Map<String, dynamic>> createTestPaymentSheet() async {
    final url = Uri.parse('/payment-sheet');
    final response =
        await networkService.call(url.toString(), RequestMethod.post, data: {
      'a': 'a',
    });

    final body = response.data;

    if (body['error'] != null) {
      throw Exception('Error code: ${body['error']}');
    }

    return body;
  }
}
