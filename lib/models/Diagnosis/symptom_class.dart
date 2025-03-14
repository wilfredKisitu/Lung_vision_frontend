class SymptomData {
  final Map<String, int> symptoms;
  final int? userId;

  SymptomData({required this.symptoms, this.userId});

  Map<String, dynamic> toJson() {
    return {
      ...symptoms,
      "userId": userId,
    };
  }
}


