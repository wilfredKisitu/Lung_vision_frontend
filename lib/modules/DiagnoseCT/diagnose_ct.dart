import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/custom_button.dart';
import 'package:lungv_app/common/image_uploader.dart';
import 'package:lungv_app/providers/CT_diagnosis/get_ct_diagnosis_service.dart';

class DiagnoseCt extends ConsumerWidget {
  const DiagnoseCt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosisResult = ref.watch(ctDiagnoseProvider);

    Future<void> uploadImage(File imageFile) async {
      await ref.read(ctDiagnoseProvider.notifier).uploadImage(imageFile);
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Upload your CT scan for diagnosis',
                style: AppTextStyles.normalTypeVar15,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Get to proactively know the variate of lung cancer your likely to be having. Tap the image area to upload CT scan',
                style: AppTextStyles.normalTypeVar14,
              ),
            ),
            // image upload

            // Diagnose by ct
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 20,
              ),
              child: ImageUploader(
                onImagePicked: (imageFile) {
                  uploadImage(imageFile);
                },
              ),
            ),

            // Scan for diagnosis
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: CustomButton(
                text: 'Scan CT for Diagnosis',
                onPressed:
                    diagnosisResult == null
                        ? null
                        : () {
                          final imageUrl = diagnosisResult.imageUrl;
                          final prediction = diagnosisResult.prediction;
                          final confidence = diagnosisResult.confidence;
                          final createdAt = diagnosisResult.createdAt;

                          context.go(
                            '/ct_details?imageUrl=${Uri.encodeComponent(imageUrl)}&prediction=${Uri.encodeComponent(prediction)}&confidence=${confidence.toString()}&createdAt=${Uri.encodeComponent(createdAt)}',
                          );
                        },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
