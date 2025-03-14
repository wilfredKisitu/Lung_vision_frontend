import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class ForecastBar extends StatelessWidget {
  final String symptom;
  final double scale;
  final double maxScale;

  const ForecastBar({
    super.key,
    required this.symptom,
    required this.scale,
    this.maxScale = 10,
  });

  @override
  Widget build(BuildContext context) {
    double barHeight = (scale / maxScale) * 250;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Forecast Power Value (Top)
        Text(
          scale.toStringAsFixed(0),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        // The Bar Representation
        Container(
          width: 30, // Bar width
          height: barHeight.clamp(10, 200), // Min height 10, max height 200
          decoration: BoxDecoration(
            color: Colors.blue, // Bar color
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: SizedBox(
            width: 70, // Ensure text doesn't make bars misaligned
            height: 40, // Fixed height for consistency
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
