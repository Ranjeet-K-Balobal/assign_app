import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/register_screen.dart';
import 'package:assign_app/views/login_screen.dart';
import 'controllers/auth_controller.dart'; // Adjust this as needed
import 'package:assign_app/models/user_model.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterScreen(), // Adjust this as needed
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
