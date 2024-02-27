import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sellers_app/screens/authentication/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(
      const Duration(seconds: 3),
      () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthScreen(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.jpg'),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                'Sell Food Online',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40,
                    fontFamily: 'Signatra',
                    letterSpacing: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
