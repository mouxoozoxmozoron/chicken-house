// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:chicken_house/APIV2/Constats/api_end_points.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRequest {
  static Future<String> login(BuildContext context, String email, String password) async {

    try {
      final response = await http.post(
        Uri.parse(authUrl),
        body: json.encode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('token')) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseBody['token']);
          return 'success'; // Indicate success
        } else {
          return 'Invalid response from server.';
        }
      } else {
        return 'Incorrect email or password.';
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }
}