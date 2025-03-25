import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserUpdateService {
  static const String baseUrl = "http://159.89.32.143:3000";

  Future<void> updateUserField(Map<String, dynamic> fieldData) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final token = prefs.getString('tokenAccess');

    if (userId == null || token == null) {
      throw Exception("Authentication data missing");
    }

    final url = Uri.parse("$baseUrl/user/$userId");

    final response = await http.put(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(fieldData),
    );

    if (response.statusCode != 200) {
      throw Exception("Update failed: ${response.body}");
    }
  }
}
