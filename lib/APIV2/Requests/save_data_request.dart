import 'dart:convert';
import 'package:chicken_house/APIV2/Constats/api_end_points.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static Future<Map<String, dynamic>> savedata(
      BuildContext context, String itemanumber, String itemName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse(saveDataUrl),
        body: json.encode({'number': itemanumber, 'item': itemName}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> responseBody;

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseBody = json.decode(response.body);

        if (responseBody.containsKey('data')) {
          return {
            'status': 'success',
            'message': 'Data saved successfully.',
          };
        } else {
          return {
            'status': 'success',
            'message': 'Response received but unexpected format.',
          };
        }
      } else {
        responseBody = json.decode(response.body);
        return {
          'status': 'error',
          'message': responseBody['message'] ?? 'An unknown error occurred.',
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'An error occurred: $e'};
    }
  }
}