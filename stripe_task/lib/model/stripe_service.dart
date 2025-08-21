import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<int> makePayment(double amount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount.toInt(),
        "usd",
      );
      print("PaymentIntent created");
      if (paymentIntentClientSecret == null) return 0;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Nor Ahmed",
        ),
      );
      await _processPayment();
      return 1;
    } on StripeException catch (e) {
      // when cansel the payment
      print('Payment canceled or failed : ${e.error.localizedMessage}');
      return 2;
    } catch (e) {
      print("Payment error: $e");
      return 0;
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final url = Uri.parse("https://api.stripe.com/v1/payment_intents");

      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      final response = await http.post(
        url,
        body: data,
        headers: {
          "Authorization": "Bearer $SecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        print(json);
        return json['client_secret'];
      } else {
        print("Stripe error: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      print('Payment canceled or failed : ${e.error.localizedMessage}');

      throw e; // rethrow to make makePayment return 2
    } catch (e) {
      print("Other payment exception: $e");
      throw e; // rethrow to make makePayment return 0
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
