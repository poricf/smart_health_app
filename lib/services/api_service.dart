import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://your-backend.com/api/v1";

  Future<void> sendMetricData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/metrics"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode >= 400) {
      throw Exception("Failed to send data: ${response.statusCode}");
    }
  }

  Future<List<Map<String, dynamic>>> fetchMetricData({
    required String userId,
    required String type,
    required String period,
  }) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/metrics/user/$userId?type=$type&period=$period"),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(json['data']);
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}
