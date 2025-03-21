import 'dart:convert';
import 'package:lungv_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://159.89.32.143:3000';

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to create use: ${response.body}');
    }
  }
}
