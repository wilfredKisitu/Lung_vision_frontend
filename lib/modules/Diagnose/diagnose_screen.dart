import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/button.dart';
import 'package:lungv_app/common/circular_indicator.dart';
import 'package:lungv_app/common/slider/slider.dart';
import 'package:lungv_app/common/slider/slider_provider.dart';
import 'package:lungv_app/modules/Diagnose/paramter_provider.dart';
import 'package:lungv_app/providers/Diagnosis/symptom_provider.dart';

class DiagnoseScreen extends ConsumerWidget {
  const DiagnoseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symptomQuestions = ref.watch(symptomQuestionsProvider);
    final currentIndex = ref.watch(symptomIndexProvider);
    final isLast = currentIndex == symptomQuestions.length - 1;
    final isFirst = currentIndex == 0;
    final symptomNotifier = ref.read(symptomProvider.notifier);
    final sliderValue = ref.watch(sliderProvider).toInt();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 5),
              child: Text(
                'New',
                textAlign: TextAlign.left,
                style: AppTextStyles.heading6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 10),
              child: Text(
                'Diagnosis',
                textAlign: TextAlign.left,
                style: AppTextStyles.heading7,
              ),
            ),

            // Symptoms
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    width: 250,
                    child: Text(
                      symptomQuestions[currentIndex].question,
                      style: AppTextStyles.normal6,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${currentIndex + 1}',
                        style: AppTextStyles.heading5,
                      ),
                      Text(
                        '/${symptomQuestions.length}',
                        style: AppTextStyles.normal6,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 20),
              child: Center(
                child: ArcWithCenteredCount(
                  unit: '/${symptomQuestions[currentIndex].maxRank}',
                ),
              ),
            ),
            Center(
              child: CustomSlider(
                maxRange: symptomQuestions[currentIndex].maxRank.toDouble(),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Text('Slide up to desired input value'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SmallButton(
                    content: (isFirst) ? 'Cancel' : Icons.chevron_left,
                    onPressed: () {
                      if (isFirst) {
                        // Navigator.of(context).pop();
                      } else {
                        // **Update Symptom Data Before Navigating**
                        symptomNotifier.updateSymptom(
                            symptomQuestions[currentIndex].symptom, sliderValue);
                        
                        // Move to Previous
                        ref.read(symptomIndexProvider.notifier).state--;

                        // Reset Slider
                        ref.read(sliderProvider.notifier).state = 0;
                      }
                    },
                  ),
                  Spacer(),
                  SmallButton(
                    content: (isLast) ? 'Forecast' : Icons.chevron_right,
                    onPressed: () {
                      // **Update Symptom Value**
                      symptomNotifier.updateSymptom(
                          symptomQuestions[currentIndex].symptom, sliderValue);

                      if (isLast) {
                        // **Show "Submitting" Snackbar**
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Submitting Diagnosis...")),
                        );

                        // **Call async function separately**
                        Future(() async {
                          try {
                            await symptomNotifier.submitDiagnosis();

                            // **Show "Success" Snackbar**
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Diagnosis Submitted Successfully!")),
                            );
                          } catch (e) {
                            // **Show Error Snackbar**
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error Submitting Diagnosis: $e")),
                            );
                          }
                        });
                      } else {
                        // **Move to Next Question**
                        ref.read(symptomIndexProvider.notifier).state++;

                        // **Reset Slider**
                        ref.read(sliderProvider.notifier).state = 0;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
