import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DemoShop/pages/intro_page.dart';
import 'components/keys.dart';
import 'model/cart_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  await _setUp();
  runApp(const MyApp());
}

Future<void> _setUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = PublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const IntroPage(),
      ),
    );
  }
}
