import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:water_level_app/water_model.dart';

class WaterApi {
  Future<List<Water>> getExperienceList() async {
    final response = await http.get(
      Uri.parse(
          "https://api.thingspeak.com/channels/2035695/feeds.json?api_key=5VYY4YMFIFUVYADW"),
    );
    if (response.statusCode == 200) {
      return ((jsonDecode(response.body)['feeds'] ?? []) as List<dynamic>)
          .map((e) => Water.fromJson(e))
          .toList();
    } else {
      throw Exception('Error getting user experience');
    }
  }
}
