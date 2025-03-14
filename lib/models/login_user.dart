// auth_model.dart
class Auth {
  final String accessToken;
  final String userId;

  Auth({required this.accessToken, required this.userId});

  // Convert JSON to Auth model
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      accessToken: json['access_token'],
      userId: json['id'].toString(),
    );
  }

  // Convert Auth model to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'id': userId};
  }
}
