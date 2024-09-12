import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:assign_app/models/user_model.dart';
import 'dart:convert';

class AuthController {
  final String registerUrl = 'http://13.127.246.196:8000/api/registers/';
  final String loginUrl = 'http://13.127.246.196:8000/login/';

  Future<void> register(UserModel user) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      print('User registered successfully');
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      print('Login successful');
    } else {
      throw Exception('Failed to login');
    }
  }
}
