class User {
  final String? name;
  final String email;
  final String yob;
  final String gender;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.yob,
    required this.gender,
    required this.password,
  });

  // Convert JSON to User model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      yob: json['YOB'],
      gender: json['gender'],
      password: json['password'],
    );
  }

  // Convert User model to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'YOB': yob,
      'gender': gender,
      'password': password,
    };
  }
}
