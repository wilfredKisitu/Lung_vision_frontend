import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class ForecastBar extends StatelessWidget {
  final String symptom;
  final double scale;
  final double maxScale;

  const ForecastBar({
    super.key,
    required this.symptom,
    required this.scale,
    this.maxScale = 9,
  });

  @override
  Widget build(BuildContext context) {
    double barHeight = (scale / maxScale) * 250;

    // Background height adjusts based on maxScale value
    double backgroundHeight = (maxScale > 0) ? 250 : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 4),

        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Dynamic gray background indicating max height
            Container(
              width: 35, 
              height: backgroundHeight, 
              decoration: BoxDecoration(
                color: AppColor.primaryGray, 
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            // The actual colored bar scaled to the current scale
            Container(
              width: 35,
              height: barHeight.clamp(10, 200), // Min height 10, max height 200
              decoration: BoxDecoration(
                color: AppColor.primaryGreen, // Bar color
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: SizedBox(
            width: 70, 
            height: 40, 
            child: Text(
              symptom,
              style: AppTextStyles.normal9,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}
