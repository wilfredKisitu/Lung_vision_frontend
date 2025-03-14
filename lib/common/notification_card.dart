import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class NotificationCard extends StatelessWidget {
  final String prefixIcon;
  final String title;
  final String risk;
  final String unit;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.risk,
    required this.unit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primaryWhite,
      elevation: 0,
      child: ListTile(
        leading: Image.asset(prefixIcon), // Prefix Icon
        title: Text(title, style: AppTextStyles.normal8),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Align unit at bottom
          children: [
            Text(
              risk, // Large count
              style: AppTextStyles.normal7,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                unit, // Smaller unit
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.chevron_right, size: 30),
          onPressed: onTap,
        ),
      ),
    );
  }
}
