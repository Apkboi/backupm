import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/services/network/network_service.dart';
import 'package:mentra/core/services/network/url_config.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/subscription/data/models/stripe_subscription_payload.dart';
import 'package:pay/pay.dart';
import 'package:uuid/uuid.dart';

class StripeService {
  static const String _publishableKey = 'your_publishable_key';

  var clientSecret = ''; // Replace with your own publishable key

  static Future<void> initialize() async {
    Stripe.publishableKey = UrlConfig.stripeTestKey;
    Stripe.merchantIdentifier = 'merchant.com.mentra.application';
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
    // await Stripe.instance.applySettings();
    // Stripe.instance.isPlatformPaySupportedListenable.addListener(() {
    //
    // });
  }

  NetworkService networkService = injector.get<NetworkService>();

  Future<void> initPaymentSheet(StripeSubscriptionPayload payload) async {
    try {
      // // 1. create payment intent on the server
      // final data = await createTestPaymentSheet();

      // create some billingdetails
      // const billingDetails = BillingDetails(
      //   name: 'Flutter Stripe',
      //   email: 'email@stripe.com',
      //   phone: '+48888000888',
      //   address: Address(
      //     city: 'Houston',
      //     country: 'US',
      //     line1: '1459  Circle Drive',
      //     line2: '',
      //     state: 'Texas',
      //     postalCode: '77063',
      //   ),
      // );

      var gpay = PaymentSheetGooglePay(
          buttonType: PlatformButtonType.subscribe,
          amount: payload.intent.data.amount.toString(),
          merchantCountryCode: 'AED',
          testEnv: true);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: payload.intent.data.clientSecret,
          merchantDisplayName: 'Mentra',
          // preferredNetworks: [CardBrand.Amex],
          // Customer params
          // customerId:  payload.intent.data.,
          customerEphemeralKeySecret: const Uuid().v4(),
          returnURL: 'flutterstripe://redirect',
          // Extra params
          primaryButtonLabel: 'Pay now',
          applePay: PaymentSheetApplePay(
              merchantCountryCode: 'AE',
              // request:
              cartItems: [
                if (payload.paymentType == PaymentType.reOcurring)
                  ApplePayCartSummaryItem.recurring(
                      label: payload.plan,
                      amount: payload.intent.data.amount.toString(),
                      intervalUnit: ApplePayIntervalUnit.month,
                      intervalCount: 1),
                if (payload.paymentType == PaymentType.onTime)
                  ApplePayCartSummaryItem.immediate(
                    label: payload.plan,
                    amount: payload.intent.data.amount.toString(),
                    // intervalUnit: ApplePayIntervalUnit.month,
                    // intervalCount: 1
                  )
              ],
              buttonType: PlatformButtonType.subscribe),
          googlePay: gpay,
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
                background: Pallets.bottomSheetColor,
                primary: Pallets.primary,
                componentBorder: Pallets.primary,
                componentText: Pallets.navy,
                primaryText: Pallets.navy,
                secondaryText: Pallets.black,
                icon: Pallets.black

                // placeholderText: Pallets.black
                ),
            shapes: PaymentSheetShape(
              // borderWidth: 4.0,
              // borderRadius: 4.0,
              shadow: PaymentSheetShadowParams(color: Pallets.grey),
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

          // billingDetails: billingDetails,
        ),
      );

      await presentPaymentSheet();
      // await confirmPayment();
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
      var res = await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      logger.w('Error${e.toString()}');
      rethrow;
    }
  }

  Future<void> confirmPayment() async {
    try {
      // 4. Confirm the payment sheet.
      await Stripe.instance.confirmPaymentSheetPayment();
    } on Exception catch (e) {
      rethrow;
    }
  }

  // Future<Map<String, dynamic>> createTestPaymentSheet() async {
  //   Map<String, dynamic> payload = {
  //     "amount": '100000',
  //     "currency": 'AED',
  //     "payment_method_types[]": [
  //       "card",
  //     ],
  //     "metadata": {
  //       "order_id": 'orderId',
  //       "email": 'email',
  //       "app_env": 'dev',
  //       "amount": 100000,
  //       "duration": 'duration',
  //       "payment_for": 'paymentFor'
  //     },
  //   };
  //   final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
  //   final response =
  //       await networkService.call(url.toString(), RequestMethod.post,
  //           data: payload,
  //           options: Options(headers: {
  //             "Authorization": 'Bearer ${UrlConfig.stripeSecretKey}',
  //             "Content-Type": "application/x-www-form-urlencoded"
  //           }));
  //
  //   final body = response.data;
  //
  //   clientSecret = body['client_secret'];
  //
  //   if (body['error'] != null) {
  //     throw Exception('Error code: ${body['error']}');
  //   }
  //
  //   return body;
  // }
}
