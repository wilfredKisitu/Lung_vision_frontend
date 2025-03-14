import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a model for symptom questions
class SymptomQuestion {
  final String symptom;
  final String question;
  final int maxRank; // Maximum rank for each symptom

  SymptomQuestion({required this.symptom, required this.question, required this.maxRank});
}

// Define a **fixed ordered list** of symptoms
final List<SymptomQuestion> _orderedSymptoms = [
  SymptomQuestion(symptom: "airPollution", question: "How much pollution are you exposed to?", maxRank: 8),
  SymptomQuestion(symptom: "alcoholUse", question: "How often do you consume alcohol?", maxRank: 8),
  SymptomQuestion(symptom: "dustAllergy", question: "How sensitive are you to dust?", maxRank: 8),
  SymptomQuestion(symptom: "occupationHazard", question: "How risky is your workplace environment?", maxRank: 8),
  SymptomQuestion(symptom: "geneticRisk", question: "How strong is your family’s health history?", maxRank: 7),
  SymptomQuestion(symptom: "chronicLungDisease", question: "How much do lung issues affect you?", maxRank: 7),
  SymptomQuestion(symptom: "balancedDiet", question: "How well do you maintain a balanced diet?", maxRank: 7),
  SymptomQuestion(symptom: "obesity", question: "How concerned are you about your weight?", maxRank: 7),
  SymptomQuestion(symptom: "smoking", question: "How frequently do you smoke?", maxRank: 8),
  SymptomQuestion(symptom: "passiveSmoker", question: "How often are you around smokers?", maxRank: 8), // Fixed casing
  SymptomQuestion(symptom: "chestPain", question: "How severe is your chest pain?", maxRank: 9),
  SymptomQuestion(symptom: "coughingOfBlood", question: "How often do you cough blood?", maxRank: 9),
  SymptomQuestion(symptom: "fatigue", question: "How easily do you get tired?", maxRank: 9),
  SymptomQuestion(symptom: "weightLoss", question: "How noticeable is your weight loss?", maxRank: 8), // Fixed casing
  SymptomQuestion(symptom: "shortnessOfBreath", question: "How often do you feel breathless?", maxRank: 9),
  SymptomQuestion(symptom: "wheezing", question: "How frequently do you wheeze?", maxRank: 8),
  SymptomQuestion(symptom: "swallowingDifficult", question: "How hard is it to swallow?", maxRank: 8), // Fixed mismatch
  SymptomQuestion(symptom: "clubbingOfFingerNails", question: "How deformed are your fingernails?", maxRank: 9), // Fixed casing
  SymptomQuestion(symptom: "frequentCold", question: "How often do you catch colds?", maxRank: 7),
  SymptomQuestion(symptom: "dryCough", question: "How persistent is your dry cough?", maxRank: 7),
  SymptomQuestion(symptom: "snoring", question: "How loud or frequent is your snoring?", maxRank: 7),
];

// **Riverpod provider that holds the ordered list of symptom questions**
final symptomQuestionsProvider = Provider<List<SymptomQuestion>>((ref) {
  return List.unmodifiable(_orderedSymptoms); // Prevents modification
});

// **State provider to keep track of the current selected symptom index**
final symptomIndexProvider = StateProvider<int>((ref) => 0);
