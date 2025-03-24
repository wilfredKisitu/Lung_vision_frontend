import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/models/Diagnosis/diagnosis_model.dart';
import 'package:lungv_app/models/login_user.dart';
import 'package:lungv_app/services/Diagnosis/diagnosis_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiagnosisNotifier extends StateNotifier<AsyncValue<List<Diagnosis>>> {
  final DiagnosisService diagnosisService;

  DiagnosisNotifier(this.diagnosisService) : super(const AsyncValue.loading());

  // Fetch diagnosis data every time this is called
  Future<void> fetchDiagnosis() async {
    try {
      state = const AsyncValue.loading();
      final auth = await loadAuthData();

      if (auth != null) {
        final diagnosisList = await diagnosisService.fetchUserDiagnosis(auth);
        state = AsyncValue.data(diagnosisList);
      } else {
        state = AsyncValue.error(
          'No authentication data found',
          StackTrace.current,
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Load authentication data
  Future<Auth?> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final tokenAccess = prefs.getString('tokenAccess');

    if (userId != null && tokenAccess != null) {
      return Auth(accessToken: tokenAccess, userId: userId);
    }
    return null;
  }
}

// Provider for the Diagnosis Service
final diagnosisServiceProvider = Provider<DiagnosisService>((ref) {
  return DiagnosisService();
});

final diagnosisProvider = StateNotifierProvider.autoDispose<
  DiagnosisNotifier,
  AsyncValue<List<Diagnosis>>
>((ref) {
  final service = ref.watch(diagnosisServiceProvider);
  return DiagnosisNotifier(service);
});

// New Provider to Fetch Diagnosis on Home Navigation**
final fetchOnHomeNavigationProvider = FutureProvider.autoDispose<void>((
  ref,
) async {
  await ref.read(diagnosisProvider.notifier).fetchDiagnosis();
});

// Class to hold prediction counts
class PredictionCount {
  final int low;
  final int medium;
  final int high;

  PredictionCount({
    required this.low,
    required this.medium,
    required this.high,
  });
}

// Provider to compute total predictions by risk
final totalPredictionsProvider = Provider.autoDispose<PredictionCount>((ref) {
  final diagnosisState = ref.watch(diagnosisProvider);

  if (diagnosisState is AsyncData<List<Diagnosis>>) {
    final List<Diagnosis> diagnoses = diagnosisState.value;

    int lowCount =
        diagnoses.where((d) => int.tryParse(d.prediction) == 0).length;
    int mediumCount =
        diagnoses.where((d) => int.tryParse(d.prediction) == 1).length;
    int highCount =
        diagnoses.where((d) => int.tryParse(d.prediction) == 2).length;

    return PredictionCount(low: lowCount, medium: mediumCount, high: highCount);
  }

  return PredictionCount(low: 0, medium: 0, high: 0);
});

// Latest diagnosis provider
final latestPredictionProvider = Provider.autoDispose<String>((ref) {
  final diagnosisState = ref.watch(diagnosisProvider);

  if (diagnosisState is AsyncData<List<Diagnosis>>) {
    final List<Diagnosis> diagnoses = diagnosisState.value;

    if (diagnoses.isNotEmpty) {
      final latestDiagnosis = diagnoses.first;
      final int? prediction = int.tryParse(latestDiagnosis.prediction);

      switch (prediction) {
        case 0:
          return "Low";
        case 1:
          return "Medium";
        case 2:
          return "High";
        default:
          return "Unknown";
      }
    }
  }
  return "No Diagnosis";
});

// Top 5 symptoms and remaining symptoms provider
final symptomsForDiagnosisProvider = Provider.family<
  Map<String, List<Map<String, dynamic>>>,
  Diagnosis
>((ref, diagnosis) {
  final Map<String, int> symptomsMap = {
    "Air Pollution": diagnosis.airPollution,
    "Alcohol Use": diagnosis.alcoholUse,
    "Dust Allergy": diagnosis.dustAllergy,
    "Occupation Hazard": diagnosis.occupationHazard,
    "Genetic Risk": diagnosis.geneticRisk,
    "Chronic Lung Disease": diagnosis.chronicLungDisease,
    "Balanced Diet": diagnosis.balancedDiet,
    "Obesity": diagnosis.obesity,
    "Smoking": diagnosis.smoking,
    "Passive Smoker": diagnosis.passiveSmoker,
    "Chest Pain": diagnosis.chestPain,
    "Coughing of Blood": diagnosis.coughingOfBlood,
    "Fatigue": diagnosis.fatigue,
    "Weight Loss": diagnosis.weightLoss,
    "Shortness of Breath": diagnosis.shortnessOfBreath,
    "Wheezing": diagnosis.wheezing,
    "Swallowing Difficulty": diagnosis.swallowingDifficult,
    "Clubbing of Fingernails": diagnosis.clubbingOfFingerNails,
    "Frequent Cold": diagnosis.frequentCold,
    "Dry Cough": diagnosis.dryCough,
    "Snoring": diagnosis.snoring,
  };

  final sortedSymptoms =
      symptomsMap.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  final topSymptoms =
      sortedSymptoms.take(5).map((entry) {
        return {"name": entry.key, "rank": entry.value};
      }).toList();

  topSymptoms.sort((a, b) => (a['rank'] as int).compareTo(b['rank'] as int));

  final remainingSymptoms =
      sortedSymptoms.skip(5).map((entry) {
        return {"name": entry.key, "rank": entry.value};
      }).toList();

  return {"topSymptoms": topSymptoms, "remainingSymptoms": remainingSymptoms};
});

// Notifications provider
final notificationsProvider = Provider.autoDispose<List<Map<String, dynamic>>>((
  ref,
) {
  final diagnosisState = ref.watch(diagnosisProvider);

  if (diagnosisState is AsyncData<List<Diagnosis>>) {
    final List<Diagnosis> diagnoses = diagnosisState.value;

    final notifications =
        diagnoses.map((diagnosis) {
          return {
            "id": diagnosis.id,
            "date": diagnosis.createdAt.toLocal().toString().split(' ')[0],
            "prediction": int.tryParse(diagnosis.prediction) ?? 0,
          };
        }).toList();

    return notifications;
  }

  return [];
});
