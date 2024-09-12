// lib/services/auth_service.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    final url = 'http://13.127.246.196:8000/login/'; // Replace with your API URL
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
