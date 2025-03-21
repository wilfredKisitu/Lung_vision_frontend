import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
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



class NotificationCard extends StatelessWidget {
  final String imagePath;
  final String riskText;
  final String predictedRisk;


  const NotificationCard({
    super.key,
    required this.imagePath,
    required this.riskText,
    required this.predictedRisk
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColor.symptomColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Prefix
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Text Content
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    riskText,
                    style: AppTextStyles.normal14,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    predictedRisk.toUpperCase(),
                    style: AppTextStyles.normal14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
