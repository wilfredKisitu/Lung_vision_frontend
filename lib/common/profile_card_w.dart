import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class ProfileCardW extends StatelessWidget {
  final IconData prefixIcon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData trailingIcon;

  const ProfileCardW({
    super.key,
    required this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primaryWhite,
      elevation: 0,
      child: ListTile(
        leading: Icon(prefixIcon, size: 24), // Prefix Icon
        title: Text(title, style: AppTextStyles.normal3),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end, // Align unit at bottom
          children: [
            Text(
              subtitle, // Large count
              style: AppTextStyles.normal2,
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(trailingIcon, size: 24),
          onPressed: onTap,
        ),
      ),
    );
  }
}
