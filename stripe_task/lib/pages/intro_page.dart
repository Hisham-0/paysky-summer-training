import 'package:flutter/material.dart';
import 'package:stripe_task/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
         mainAxisSize: MainAxisSize.min,
          children: [
            //logo
            Container(
              alignment: Alignment.center,
              height: 400.0,
              width: 400.0,
              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1661914978519-52a11fe159a7?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            // App name
            const Text(
              "Shopping App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            // every thing you want
            const Text(
              "every thing you want",
              style: TextStyle(fontSize: 17.0, color: Colors.grey),
            ),
            const SizedBox(height: 40.0),
            // get start
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Get Start",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                    SizedBox(width: 10.0),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 30.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
