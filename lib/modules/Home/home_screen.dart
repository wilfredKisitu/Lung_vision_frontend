import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/count_with_unit.dart';
import 'package:lungv_app/common/infor_card.dart';
import 'package:lungv_app/common/profile_card_w.dart';
import 'package:lungv_app/common/symptom_graph.dart';
import 'package:lungv_app/providers/Diagnosis/diagnosis_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOnboarding());
  }

  Future<void> _checkOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool('hasCompletedOnboarding') ?? false;

    if (!hasSeen && mounted) {
      await showDialog(
        context: context,
        builder: (_) => const _OnboardingDialog(),
      );
      await prefs.setBool('hasCompletedOnboarding', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(fetchOnHomeNavigationProvider);
    final diagnosisState = ref.watch(diagnosisProvider);
    final predictionCounts = ref.watch(totalPredictionsProvider);
    final latestPrediction = ref.watch(latestPredictionProvider);
    final notifications = ref.watch(notificationsProvider);

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: diagnosisState.when(
                    data: (diagnosis) {
                      diagnosis.sort(
                        (a, b) => b.createdAt.compareTo(a.createdAt),
                      );
                      final latestDiagnosis =
                          diagnosis.isNotEmpty ? diagnosis[0] : null;
                      return SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (latestDiagnosis != null) ...[
                              CountWithUnitHeader(
                                count: diagnosis.length,
                                unit: 'Tests',
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  _formatDate(
                                    latestDiagnosis.createdAt.toString(),
                                  ),
                                  style: AppTextStyles.normal14,
                                ),
                              ),
                            ] else ...[
                              Text('No diagnosis'),
                            ],
                          ],
                        ),
                      );
                    },
                    error:
                        (error, _) =>
                            CountWithUnitHeader(count: 0, unit: 'Tests'),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Image.asset('assets/images/diagnose.png', height: 120),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Statistics', style: AppTextStyles.headingType1),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InfoCard(
                        imagePath: 'assets/images/low_icon.png',
                        title: 'LOW',
                        count: predictionCounts.low,
                        unit: 'Recorded Low Cases',
                        backgroundImagePath: 'assets/images/Low_gradient.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InfoCard(
                        imagePath: 'assets/images/meduim_icon.png',
                        title: 'MEDIUM',
                        count: predictionCounts.medium,
                        unit: 'Recorded Meduim Cases',
                        backgroundImagePath: 'assets/images/Low_gradient.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InfoCard(
                        imagePath: 'assets/images/high_icon.png',
                        title: 'HIGH',
                        count: predictionCounts.high,
                        unit: 'Recorded High Cases',
                        backgroundImagePath: 'assets/images/high_gradient.png',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text('Diagnosis', style: AppTextStyles.headingType1),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_risk(latestPrediction, 'Risk')],
                  ),
                ),
                Spacer(),
                Image.asset('assets/images/recent.png', height: 70),
              ],
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text('Top Symptoms', style: AppTextStyles.normalType2),
            ),

            SizedBox(height: 40),
            Center(
              child: diagnosisState.when(
                data: (diagnosis) {
                  if (diagnosis.isEmpty) return Text('No symptom data!');
                  final latestDiagnosis = diagnosis.first;
                  final symptomsData = ref.watch(
                    symptomsForDiagnosisProvider(latestDiagnosis),
                  );
                  final topSymptoms = symptomsData['topSymptoms']!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                        topSymptoms.map((symptom) {
                          return ForecastBar(
                            symptom: symptom['name'],
                            scale: (symptom['rank'] as num).toDouble(),
                          );
                        }).toList(),
                  );
                },
                error:
                    (_, __) =>
                        Center(child: Text('No symptoms data available...')),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Text('History', style: AppTextStyles.headingType1),
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                double screenHeight = MediaQuery.of(context).size.height;
                double minHeight = 100;
                double maxHeight = screenHeight * 0.5;
                double calculatedHeight =
                    (notifications.length * 80).toDouble();

                return SizedBox(
                  height: calculatedHeight.clamp(minHeight, maxHeight),
                  child: diagnosisState.when(
                    data: (diagnosis) {
                      if (diagnosis.isEmpty) {
                        return Center(
                          child: Text(
                            'No data available',
                            style: AppTextStyles.normal14,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: notifications.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return ProfileCardW(
                            prefixIcon: getRiskIcon(notification['prediction']),
                            title: _formatDate(notification['date'].toString()),
                            subtitle: getRiskText(notification['prediction']),
                            onTap:
                                () => context.push(
                                  '/details/${notification['id']}',
                                ),
                            trailingIcon: Icons.chevron_right,
                          );
                        },
                      );
                    },
                    error:
                        (_, __) => Center(
                          child: Text('Error occurred loading history'),
                        ),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Onboarding Dialog
class _OnboardingDialog extends StatelessWidget {
  const _OnboardingDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Welcome to LungVision!"),
      content: const Text(
        "To take your first diagnosis:\n\n"
        "1️⃣ Tap the 'Diagnose' tab below\n"
        "2️⃣ Answer simple questions about your lifestyle & health\n"
        "3️⃣ Get your risk level and insights!\n\n"
        "You can always repeat this test later.",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Got it!"),
        ),
      ],
    );
  }
}

// Date Formatter
String _formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) return 'Unknown Date';
  try {
    final DateTime parsedDate = DateTime.parse(dateString);
    return DateFormat('d MMM, yyyy').format(parsedDate);
  } catch (e) {
    return 'Invalid Date';
  }
}

// Risk Widget
Widget _risk(String risk, String unit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(risk.toUpperCase(), style: AppTextStyles.headingType2),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(unit, style: AppTextStyles.normal14),
      ),
    ],
  );
}

// Risk Labels
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

// Risk Icons
String getRiskIcon(int prediction) {
  switch (prediction) {
    case 0:
      return 'assets/images/low_icon.png';
    case 1:
      return 'assets/images/meduim_icon.png';
    case 2:
      return 'assets/images/high_icon.png';
    default:
      return 'assets/images/low_icon.png';
  }
}
