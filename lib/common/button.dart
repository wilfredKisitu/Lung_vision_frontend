import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class SmallButton extends StatelessWidget {
  final dynamic content; // Can be String (text) or IconData (icon)
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;

  const SmallButton({
    super.key,
    required this.content,
    required this.onPressed,
    this.color = AppColor.primaryOrange,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        minimumSize: const Size(40, 40), // Ensures a minimum size
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Wraps content dynamically
        children: [
          if (content is String)
            Text(
              content, // Display text
              style: AppTextStyles.btn1,
            )
          else if (content is IconData)
            Icon(
              content as IconData, // Display icon
              color: AppColor.primaryWhite,
              size: 20,
            ),
        ],
      ),
    );
  }
}
