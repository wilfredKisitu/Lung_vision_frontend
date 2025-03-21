import 'package:http/http.dart' as http;
import 'package:lungv_app/models/Diagnosis/diagnosis_model.dart';
import 'dart:convert';
import 'package:lungv_app/models/login_user.dart';

class DiagnosisService {
  final String baseUrl = "http://159.89.32.143:3000";

  Future<List<Diagnosis>> fetchUserDiagnosis(Auth auth) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/diagnose/user/${auth.userId}'),
        headers: {
          'Authorization': 'Bearer ${auth.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) => Diagnosis.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch diagnosis data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
