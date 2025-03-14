import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/models/Diagnosis/symptom_class.dart';
import 'package:lungv_app/services/Diagnosis/get_diagnosis.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SymptomNotifier extends StateNotifier<SymptomData> {
  SymptomNotifier()
      : super(SymptomData(
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
        ));

  // **Update the value of a symptom from slider input while preserving order**
  void updateSymptom(String key, int value) {
    final updatedSymptoms = Map<String, int>.from(state.symptoms);
    updatedSymptoms[key] = value; // Preserve original order

    state = SymptomData(
      symptoms: updatedSymptoms,
      userId: state.userId,
    );
  }

  // **Retrieve the value of a specific symptom**
  int getSymptom(String key) {
    return state.symptoms[key] ?? 0;
  }

  // **Reset all symptoms to 0 while maintaining order**
  void resetSymptoms() {
    final resetSymptoms = {
      for (var key in state.symptoms.keys) key: 0, // Preserve order
    };

    state = SymptomData(
      symptoms: resetSymptoms,
      userId: state.userId,
    );
  }

  // **Load `userId` from SharedPreferences before submission**
  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = int.tryParse(prefs.getString('userId') ?? '0');

    state = SymptomData(
      symptoms: state.symptoms,
      userId: userId,
    );
  }

  // **Submit Diagnosis Data to API**
  Future<void> submitDiagnosis() async {
    try {
      // Ensure `userId` is loaded before submitting
      await loadUserId();

      // Ensure `userId` is included while preserving order
      final Map<String, int> orderedSymptoms = {
        ...state.symptoms, // Maintain order
        "userId": state.userId ?? 0, // Append userId
      };

      // Send to API Service
      await ApiService.submitDiagnosis(orderedSymptoms);
    } catch (e) {
      print("Error submitting diagnosis: $e");
    }
  }
}

// **Provider for Symptom State**
final symptomProvider =
    StateNotifierProvider<SymptomNotifier, SymptomData>((ref) {
  final notifier = SymptomNotifier();
  notifier.loadUserId();

  // Prevent provider from being disposed
  ref.keepAlive();

  return notifier;
});
