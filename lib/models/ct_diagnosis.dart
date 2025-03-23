class CtDiagnoseResult {
  final String imageUrl;
  final String prediction;
  final double confidence;

  CtDiagnoseResult({
    required this.imageUrl,
    required this.prediction,
    required this.confidence,
  });

  factory CtDiagnoseResult.fromJson(Map<String, dynamic> json) {
    return CtDiagnoseResult(
      imageUrl: json['result']['imageUrl'],
      prediction: json['result']['prediction'],
      confidence: json['result']['confidence'],
    );
  }
}
