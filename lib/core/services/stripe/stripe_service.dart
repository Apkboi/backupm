import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:pay/pay.dart';

class StripeService {
  static const String _publishableKey = 'your_publishable_key';

  var clientSecret = ''; // Replace with your own publishable key

  static Future<void> initialize() async {
    Stripe.publishableKey = UrlConfig.stripeTestKey;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
    // await Stripe.instance.applySettings();
    // Stripe.instance.isPlatformPaySupportedListenable.addListener(() {
    //
    // });
  }

  NetworkService networkService = injector.get<NetworkService>();

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createTestPaymentSheet();

      // create some billingdetails
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      );

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: 'AED', testEnv: true);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: data['client_secret'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          // preferredNetworks: [CardBrand.Amex],
          // Customer params
          customerId: data['customer'],

          customerEphemeralKeySecret: data['ephemeralKey'],
          returnURL: 'flutterstripe://redirect',

          // Extra params
          primaryButtonLabel: 'Pay now',
          applePay: PaymentSheetApplePay(
              merchantCountryCode: 'AED',

              buttonType: PlatformButtonType.subscribe),
          googlePay: gpay,
          style: ThemeMode.dark,

          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.lightBlue,
              primary: Colors.blue,
              componentBorder: Colors.red,
            ),
            shapes: PaymentSheetShape(
              // borderWidth: 4.0,
              // borderRadius: 4.0,
              shadow: PaymentSheetShadowParams(color: Colors.red),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color.fromARGB(255, 231, 235, 30),
                  text: Color.fromARGB(255, 235, 92, 30),
                  // border: Color.fromARGB(255, 235, 92, 30),
                ),
              ),
            ),
          ),
          billingDetails: billingDetails,
        ),
      );

      // logger.w(rs?.toJson());

      // await Stri
      // setState(() {
      //   step = 1;
      // });
      await presentPaymentSheet();
    } catch (e) {
      logger.e(e.toString());
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error: $e')),
      // );
      rethrow;
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      // Stripe.instance.presentGooglePay(PresentGooglePayParams(clientSecret: clientSecret));
      var res = await Stripe.instance.presentPaymentSheet(

          // options: PaymentSheetPresentOptions(timeout: )
          // clientSecret: clientSecret,
          // confirmParams: const PlatformPayConfirmParams.googlePay(
          //     googlePay: GooglePayParams(
          //         allowCreditCards: true,
          //         merchantName: 'Mentra',
          //         testEnv: true,
          //         merchantCountryCode: 'AED',
          //         currencyCode: 'AED'))
          );
      // logger.w('presenting${res?.toJson()}');

      // setState(() {
      //   step = 2;
      // });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Payment option selected'),
      //   ),
      // );
    } catch (e) {
      logger.w('Error${e.toString()}');

      if (e is StripeException) {
        logger.w('Error${e.error.localizedMessage}');

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
    Map<String, dynamic> payload = {
      "amount": '100000',
      "currency": 'AED',
      "payment_method_types[]": [
        "card",
      ],
      "metadata": {
        "order_id": 'orderId',
        "email": 'email',
        "app_env": 'dev',
        "amount": 100000,
        "duration": 'duration',
        "payment_for": 'paymentFor'
      },
    };
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final response =
        await networkService.call(url.toString(), RequestMethod.post,
            data: payload,
            options: Options(headers: {
              "Authorization":
                  'Bearer sk_test_51IIZDzIshQwWGM1okIkVHeXQ5Lb1gDto5pKaWsDCY1QHPMB3wqUWg9V3sWcesCliKP6CVKINoawRErr9XGclukKj00cp2S7Xr8',
              "Content-Type": "application/x-www-form-urlencoded"
            }));

    final body = response.data;

    clientSecret = body['client_secret'];

    if (body['error'] != null) {
      throw Exception('Error code: ${body['error']}');
    }

    return body;
  }
}
