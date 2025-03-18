import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class InfoCard extends StatelessWidget {
  final String imagePath; // Prefix image
  final String backgroundImagePath; // Background image
  final String title;
  final String unit;
  final int count;

  const InfoCard({
    super.key,
    required this.imagePath,
    required this.backgroundImagePath, // Background image required
    required this.title,
    required this.count,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270, // Ensure a reasonable min & max width
      height: 170,
      padding: const EdgeInsets.all(12), // Padding inside the card
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.blackWithOpacity70,
          width: 0.5,
        ), // Border
        borderRadius: BorderRadius.circular(15), // Rounded corners
        image: DecorationImage(
          image: AssetImage(backgroundImagePath), // Background image
          fit: BoxFit.cover, // Adjusts image to cover the card
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [

              const SizedBox(width: 8), 
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.cardStyle,
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White background
                ),
                padding: const EdgeInsets.all(4), // Optional padding for spacing
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    width: 28,
                    height: 28,
                    fit: BoxFit.cover, // Ensures the image fills the circular shape
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          // Row for Count & Unit
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start, // Align unit to bottom
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  '$count', 
                  style: AppTextStyles.cardStyle3,
                ),
              ),
              const SizedBox(width: 4), 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  unit, 
                  style: AppTextStyles.cardStyle2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
