import 'dart:convert';
import 'package:chicken_house/APIV2/Constats/api_end_points.dart';
import 'package:chicken_house/APIV2/Utils/Models/todaysdatamodel.dart';
import 'package:http/http.dart' as http;

class ChickebService {
  static Future<TodaysaData> fetchTodaysData() async {
    final response = await http.get(Uri.parse(todaysDataUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return TodaysaData.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}