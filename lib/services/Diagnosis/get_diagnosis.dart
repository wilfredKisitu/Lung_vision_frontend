import 'package:lungv_app/models/Diagnosis/diagnosis_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://159.89.32.143:3000";

  // **Fetch User Data (User ID & Token)**
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = int.tryParse(prefs.getString('userId') ?? '0');
    final token = prefs.getString('tokenAccess') ?? '';

    if (userId == null || token.isEmpty) {
      throw Exception("User authentication data missing.");
    }

    return {"userId": userId, "token": token};
  }

  // **POST: Submit Diagnosis**
  static Future<Diagnosis> submitDiagnosis(Map<String, int> symptomData) async {
    try {
      final userData = await getUserData();
      final int userId = userData["userId"];
      final String token = userData["token"];

      final requestBody = {...symptomData, "userId": userId};
      final url = Uri.parse("$baseUrl/diagnose");

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Diagnosis.fromJson(data);
      } else {
        throw Exception("Failed to submit diagnosis: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error submitting diagnosis: $e");
    }
  }
}
