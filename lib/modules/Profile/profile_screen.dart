import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/Constants/image_paths.dart';
import 'package:lungv_app/common/profile_card_w.dart';
import 'package:lungv_app/common/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: UserProfile(imagePath: ImagePath.profileImage),
              ),
            ),
            // Account Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('Account Information', style: AppTextStyles.normal2),
            ),
            // Profile cards
            Center(
              child: Column(
                // username
                children: [
                  ProfileCardW(
                    prefixIcon: Icons.person,
                    title: 'Name',
                    subtitle: "JamesK",
                    onTap: () {},
                    trailingIcon: Icons.edit,
                  ),
                  // email
                  ProfileCardW(
                    prefixIcon: Icons.email,
                    title: 'Email',
                    subtitle: "JamesMoraK@gmail.com",
                    onTap: () {},
                    trailingIcon: Icons.edit,
                  ),
                  // Password
                  ProfileCardW(
                    prefixIcon: Icons.lock,
                    title: 'Change Password',
                    subtitle: "*******",
                    onTap: () {},
                    trailingIcon: Icons.edit,
                  ),
                  // Theme
                  ProfileCardW(
                    prefixIcon: Icons.settings,
                    title: 'Theme',
                    subtitle: "System",
                    onTap: () {},
                    trailingIcon: Icons.edit,
                  ),
                  // updates
                  // Theme
                  ProfileCardW(
                    prefixIcon: Icons.update_sharp,
                    title: 'Updates',
                    subtitle: "Recent software updates",
                    onTap: () {},
                    trailingIcon: Icons.edit,
                  ),
                  ProfileCardW(
                    prefixIcon: Icons.logout,
                    title: 'Logout',
                    subtitle: "Recent software updates",
                    onTap: () {
                      context.go('/login');
                    },
                    trailingIcon: Icons.arrow_forward,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
