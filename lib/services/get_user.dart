import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lungv_app/models/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataService {
  static const String baseUrl = "http://159.89.32.143:3000";

  Future<User> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final token = prefs.getString('tokenAccess');

    if (userId == null || token == null) {
      throw Exception("Missing authentication data");
    }

    final url = Uri.parse("$baseUrl/user/$userId");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception("Failed to fetch user data: ${response.body}");
    }
  }
}
