class User {
  final int id;
  final String name;
  final String email;
  final String YOB;
  final String gender;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.YOB,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      YOB: json['YOB'],
      gender: json['gender'],
    );
  }
}
