class CtDiagnoseResult {
  final String imageUrl;
  final String prediction;
  final double confidence;
  final String createdAt;

  CtDiagnoseResult({
    required this.imageUrl,
    required this.prediction,
    required this.confidence,
    required this.createdAt,
  });

  factory CtDiagnoseResult.fromJson(Map<String, dynamic> json) {
    return CtDiagnoseResult(
      imageUrl: json['result']['imageUrl'],
      prediction: json['result']['prediction'],
      confidence: json['result']['confidence'],
      createdAt: json['result']['createdAt'],
    );
  }
}
