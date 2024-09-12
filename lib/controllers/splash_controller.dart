// lib/controllers/splash_controller.dart

import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  Future<void> startSplashTimer(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3)); // Simulate a delay
    Navigator.pushReplacementNamed(context, '/home'); // Navigate to home screen after delay
  }
}
