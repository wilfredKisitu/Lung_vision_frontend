import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lungv_app/models/login_user.dart';
import 'package:lungv_app/providers/Auth/auth_provider.dart';
import 'package:lungv_app/providers/Auth/user_provider.dart';
import 'package:lungv_app/providers/CT_diagnosis/get_ct_diagnosis_service.dart';
import 'package:lungv_app/providers/Diagnosis/diagnosis_provider.dart';
import 'package:lungv_app/providers/Diagnosis/symptom_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://159.89.32.143:3000";

  Future<Auth> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        final authResponse = Auth.fromJson(data);

        // Save the user data (userId and accessToken) in shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', authResponse.userId);
        prefs.setString('tokenAccess', authResponse.accessToken);

        return authResponse;
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        throw Exception(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Load stored authentication data (userId and tokenAccess)
  Future<Auth?> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final tokenAccess = prefs.getString('tokenAccess');

    if (userId != null && tokenAccess != null) {
      return Auth(accessToken: tokenAccess, userId: userId);
    }
    return null;
  }
}

// logout user
Future<void> logoutUser(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
  await prefs.remove('tokenAccess');
  ref.invalidate(diagnosisProvider);
  ref.invalidate(fetchOnHomeNavigationProvider);
  ref.invalidate(totalPredictionsProvider);
  ref.invalidate(latestPredictionProvider);
  ref.invalidate(userProvider);
  ref.invalidate(authProvider);
  ref.invalidate(authServiceProvider);
  ref.invalidate(userServiceProvider);
  ref.invalidate(userProvider);
  ref.invalidate(ctDiagnoseProvider);
  ref.invalidate(notificationsProvider);
  ref.invalidate(symptomsForDiagnosisProvider);
  ref.invalidate(diagnosisServiceProvider);
  ref.invalidate(symptomProvider);
}
