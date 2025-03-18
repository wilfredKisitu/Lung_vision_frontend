import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';

class ProfileCardW extends StatelessWidget {
  final dynamic prefixIcon; // Can be IconData or String (image path)
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
        leading: _buildLeadingIcon(), // Dynamically build the leading widget
        title: Text(title, style: AppTextStyles.normal3),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.normal2,
        ),
        trailing: IconButton(
          icon: Icon(trailingIcon, size: 24),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    if (prefixIcon is IconData) {
      return Icon(prefixIcon, size: 24, color: Colors.black);
    } else if (prefixIcon is String) {
      return Image.asset(prefixIcon, width: 30, height: 30, fit: BoxFit.cover);
    } else {
      return const SizedBox.shrink(); // Empty widget if the type is invalid
    }
  }
}
