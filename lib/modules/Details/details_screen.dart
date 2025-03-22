import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/count_with_unit.dart';
import 'package:lungv_app/common/other_symptoms.dart';
import 'package:lungv_app/common/symptom_graph.dart';
import 'package:lungv_app/providers/Diagnosis/diagnosis_provider.dart';

class DetailsScreen extends ConsumerWidget {
  final String diagnosisId;
  const DetailsScreen({super.key, required this.diagnosisId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosisState = ref.watch(diagnosisProvider);

    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: AppBar(
        // title: Image.asset('assets/images/logo_small.png'),
        backgroundColor: AppColor.primaryWhite,
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/main');
          },
          icon: Icon(Icons.chevron_left, size: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: diagnosisState.when(
            data: (diagnoses) {
              // **Find the matching Diagnosis using `diagnosisId`**
              final diagnosis = diagnoses.firstWhere((d) => d.id == int.tryParse(diagnosisId));

              // **Fetch symptoms for the selected Diagnosis**
              final symptomsData = ref.watch(symptomsForDiagnosisProvider(diagnosis));
              final topSymptoms = symptomsData['topSymptoms'] ?? [];
              final remainingSymptoms = symptomsData['remainingSymptoms'] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // **Risk Section**
                  
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CountWithUnit(
                                count: getRiskText(int.tryParse(diagnosis.prediction) ?? -1),
                                unit: 'Risk',
                              ),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Text(
                                _formatDate(diagnosis.createdAt.toString()),
                                style: AppTextStyles.normal14,
                              ), 
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              //   child: Text(diagnosis.createdAt.toLocal().toString().split(' ')[0]),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      // **Image**
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Image.asset('assets/images/recent.png'),
                      ),
                    ],
                  ),
                  // **Top Symptoms Section**
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text('Top 5 Symptoms', style: AppTextStyles.headingTypeVar1),
                  ),
                  // **Graph Plots**
                  SizedBox(height: 40,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: topSymptoms.map((symptom) {
                        return ForecastBar(
                          symptom: symptom['name'],
                          scale: (symptom['rank'] as num).toDouble(),
                        );
                      }).toList(),
                    ),
                  ),
                  // **Other Symptoms Section**
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text('Other Symptoms', style: AppTextStyles.headingTypeVar1),
                  ),
                  // **Symptom Cards**
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: remainingSymptoms.map((symptom) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
                          child: NotificationCard(
                            imagePath: getIcon(symptom['rank']), 
                            riskText: symptom['name'],
                            predictedRisk: rankTranslate(symptom['rank']),
                            ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text("Error loading data: $err")),
          ),
        ),
      ),
    );
  }
}

// Get Risk
String getRiskText(int prediction) {
  switch (prediction) {
    case 0:
      return 'Low';
    case 1:
      return 'Medium';
    case 2:
      return 'High';
    default:
      return 'Unknown';
  }
}



// Translate ranks 
String rankTranslate(int rank) {
  if (rank <= 3) {
    return 'Low';
  } else if (rank > 3 && rank <= 6) {
    return 'Moderate';
  } else {
    return 'High';
  }
}

String getIcon(int rank) {
  if (rank <= 3) {
    return 'assets/images/notification_low.png';
  } else if (rank > 3 && rank <= 6) {
    return 'assets/images/notification_meduim.png';
  } else {
    return 'assets/images/notification_high.png';
  }
}

// formart data
String _formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return 'Unknown Date'; // Handle null or empty strings
  }

  try {
    final DateTime parsedDate = DateTime.parse(dateString);
    return DateFormat('d MMM, yyyy').format(parsedDate);
  } catch (e) {
    return 'Invalid Date'; // Handle parsing errors
  }
}
