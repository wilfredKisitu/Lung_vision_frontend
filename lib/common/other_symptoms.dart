import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class OtherSymptoms extends StatelessWidget {
  final String symptom;
  final String risk;
  final int rank;

  const OtherSymptoms({
    super.key,
    required this.symptom,
    required this.risk,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3, // Adjust as needed
            child: Text(
              symptom,
              style: AppTextStyles.normal2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              risk,
              style: AppTextStyles.normal2,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$rank',
              style: AppTextStyles.normal2,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
