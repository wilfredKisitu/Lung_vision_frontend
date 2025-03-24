import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Text(
                'New Diagnosis',
                textAlign: TextAlign.left,
                style: AppTextStyles.headingType1,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    width: 280,
                    child: Text(
                      symptomQuestions[currentIndex].question,
                      style: AppTextStyles.normalType6,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${currentIndex + 1}',
                        style: AppTextStyles.headingType5,
                      ),
                      Text(
                        ' / ${symptomQuestions.length}',
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
            const SizedBox(height: 15),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Text(
                  'Slide up to desired input value',
                  style: AppTextStyles.normal14,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  SmallButton(
                    content: (isFirst) ? 'Cancel' : Icons.chevron_left,
                    onPressed: () {
                      if (isFirst) {
                        // Optionally pop or navigate back
                      } else {
                        symptomNotifier.updateSymptom(
                          symptomQuestions[currentIndex].symptom,
                          sliderValue,
                        );
                        ref.read(symptomIndexProvider.notifier).state--;
                        ref.read(sliderProvider.notifier).state = 0;
                      }
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20,
                    ),
                    child: SmallButton(
                      content: (isLast) ? 'Forecast' : Icons.chevron_right,
                      onPressed: () {
                        symptomNotifier.updateSymptom(
                          symptomQuestions[currentIndex].symptom,
                          sliderValue,
                        );

                        if (isLast) {
                          _handleDiagnosisSubmission(context, ref);
                        } else {
                          ref.read(symptomIndexProvider.notifier).state++;
                          ref.read(sliderProvider.notifier).state = 0;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Handles the submission and redirection logic
  Future<void> _handleDiagnosisSubmission(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final symptomNotifier = ref.read(symptomProvider.notifier);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Diagnosing...")));

    try {
      final diagnosis = await symptomNotifier.submitDiagnosis();

      if (context.mounted) {
        context.go('/detailsparsed/${diagnosis.id}', extra: diagnosis);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Diagnosis Submitted Successfully!")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Submitting Diagnosis: $e")),
        );
      }
    }
  }
}
