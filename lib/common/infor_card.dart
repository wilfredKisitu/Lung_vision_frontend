import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';

class InfoCard extends StatelessWidget {
  final String imagePath; // Prefix image
  final String title;
  final String unit;
  final int count;

  const InfoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.count,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth =
        MediaQuery.of(context).size.width * 0.42; // Reduced width to 35%

    return Container(
      width: maxWidth.clamp(120, 180), // Ensure a reasonable min & max width
      padding: const EdgeInsets.all(12), // Padding inside the card
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.blackWithOpacity70,
          width: 0.5,
        ), // Border
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Image & Title
          Row(
            children: [
              Image.asset(imagePath, width: 28, height: 28), // Prefix Image
              const SizedBox(width: 8), // Spacing between image and title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
              ),
            ],
          ),

          const SizedBox(height: 10), // Spacing before count
          // Row for Count & Unit
          Row(
            crossAxisAlignment: CrossAxisAlignment.end, // Align unit to bottom
            children: [
              Text(
                '$count', // Large count
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4), // Spacing between count and unit
              Text(
                unit, // Smaller unit
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
