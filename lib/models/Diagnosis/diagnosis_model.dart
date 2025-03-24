class Diagnosis {
  final int id;
  final int airPollution;
  final int alcoholUse;
  final int dustAllergy;
  final int occupationHazard;
  final int geneticRisk;
  final int chronicLungDisease;
  final int balancedDiet;
  final int obesity;
  final int smoking;
  final int passiveSmoker;
  final int chestPain;
  final int coughingOfBlood;
  final int fatigue;
  final int weightLoss;
  final int shortnessOfBreath;
  final int wheezing;
  final int swallowingDifficult;
  final int clubbingOfFingerNails;
  final int frequentCold;
  final int dryCough;
  final int snoring;
  final String prediction;
  final DateTime createdAt;

  Diagnosis({
    required this.id,
    required this.airPollution,
    required this.alcoholUse,
    required this.dustAllergy,
    required this.occupationHazard,
    required this.geneticRisk,
    required this.chronicLungDisease,
    required this.balancedDiet,
    required this.obesity,
    required this.smoking,
    required this.passiveSmoker,
    required this.chestPain,
    required this.coughingOfBlood,
    required this.fatigue,
    required this.weightLoss,
    required this.shortnessOfBreath,
    required this.wheezing,
    required this.swallowingDifficult,
    required this.clubbingOfFingerNails,
    required this.frequentCold,
    required this.dryCough,
    required this.snoring,
    required this.prediction,
    required this.createdAt,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'],
      airPollution: json['airPollution'],
      alcoholUse: json['alcoholUse'],
      dustAllergy: json['dustAllergy'],
      occupationHazard: json['occupationHazard'],
      geneticRisk: json['geneticRisk'],
      chronicLungDisease: json['chronicLungDisease'],
      balancedDiet: json['balancedDiet'],
      obesity: json['obesity'],
      smoking: json['smoking'],
      passiveSmoker: json['passiveSmoker'],
      chestPain: json['chestPain'],
      coughingOfBlood: json['coughingOfBlood'],
      fatigue: json['fatigue'],
      weightLoss: json['weightLoss'],
      shortnessOfBreath: json['shortnessOfBreath'],
      wheezing: json['wheezing'],
      swallowingDifficult: json['swallowingDifficult'],
      clubbingOfFingerNails: json['clubbingOfFingerNails'],
      frequentCold: json['frequentCold'],
      dryCough: json['dryCough'],
      snoring: json['snoring'],
      prediction: json['prediction'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airPollution': airPollution,
      'alcoholUse': alcoholUse,
      'dustAllergy': dustAllergy,
      'occupationHazard': occupationHazard,
      'geneticRisk': geneticRisk,
      'chronicLungDisease': chronicLungDisease,
      'balancedDiet': balancedDiet,
      'obesity': obesity,
      'smoking': smoking,
      'passiveSmoker': passiveSmoker,
      'chestPain': chestPain,
      'coughingOfBlood': coughingOfBlood,
      'fatigue': fatigue,
      'weightLoss': weightLoss,
      'shortnessOfBreath': shortnessOfBreath,
      'wheezing': wheezing,
      'swallowingDifficult': swallowingDifficult,
      'clubbingOfFingerNails': clubbingOfFingerNails,
      'frequentCold': frequentCold,
      'dryCough': dryCough,
      'snoring': snoring,
      'prediction': prediction,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Map<String, int> toSymptomMap() {
    return {
      'airPollution': airPollution,
      'alcoholUse': alcoholUse,
      'dustAllergy': dustAllergy,
      'occupationHazard': occupationHazard,
      'geneticRisk': geneticRisk,
      'chronicLungDisease': chronicLungDisease,
      'balancedDiet': balancedDiet,
      'obesity': obesity,
      'smoking': smoking,
      'passiveSmoker': passiveSmoker,
      'chestPain': chestPain,
      'coughingOfBlood': coughingOfBlood,
      'fatigue': fatigue,
      'weightLoss': weightLoss,
      'shortnessOfBreath': shortnessOfBreath,
      'wheezing': wheezing,
      'swallowingDifficult': swallowingDifficult,
      'clubbingOfFingerNails': clubbingOfFingerNails,
      'frequentCold': frequentCold,
      'dryCough': dryCough,
      'snoring': snoring,
    };
  }
}
