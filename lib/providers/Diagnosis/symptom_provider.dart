import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/models/Diagnosis/diagnosis_model.dart';
import 'package:lungv_app/models/Diagnosis/symptom_class.dart';
import 'package:lungv_app/services/Diagnosis/get_diagnosis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymptomNotifier extends StateNotifier<SymptomData> {
  SymptomNotifier()
    : super(
        SymptomData(
          symptoms: {
            "airPollution": 0,
            "alcoholUse": 0,
            "dustAllergy": 0,
            "occupationHazard": 0,
            "geneticRisk": 0,
            "chronicLungDisease": 0,
            "balancedDiet": 0,
            "obesity": 0,
            "smoking": 0,
            "passiveSmoker": 0,
            "chestPain": 0,
            "coughingOfBlood": 0,
            "fatigue": 0,
            "weightLoss": 0,
            "shortnessOfBreath": 0,
            "wheezing": 0,
            "swallowingDifficult": 0,
            "clubbingOfFingerNails": 0,
            "frequentCold": 0,
            "dryCough": 0,
            "snoring": 0,
          },
        ),
      );

  void updateSymptom(String key, int value) {
    final updatedSymptoms = Map<String, int>.from(state.symptoms);
    updatedSymptoms[key] = value;

    state = SymptomData(symptoms: updatedSymptoms, userId: state.userId);
  }

  int getSymptom(String key) {
    return state.symptoms[key] ?? 0;
  }

  void resetSymptoms() {
    final resetSymptoms = {for (var key in state.symptoms.keys) key: 0};

    state = SymptomData(symptoms: resetSymptoms, userId: state.userId);
  }

  // **Load `userId` from SharedPreferences before submission**
  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = int.tryParse(prefs.getString('userId') ?? '0');

    state = SymptomData(symptoms: state.symptoms, userId: userId);
  }

  Future<Diagnosis> submitDiagnosis() async {
    try {
      await loadUserId();
      final Map<String, int> orderedSymptoms = {
        ...state.symptoms,
        "userId": state.userId ?? 0,
      };

      final diagnosis = await ApiService.submitDiagnosis(orderedSymptoms);
      return diagnosis;
    } catch (e) {
      throw Exception("Error submitting diagnosis: $e");
    }
  }
}

final symptomProvider = StateNotifierProvider<SymptomNotifier, SymptomData>((
  ref,
) {
  final notifier = SymptomNotifier();
  notifier.loadUserId();
  ref.keepAlive();
  return notifier;
});
