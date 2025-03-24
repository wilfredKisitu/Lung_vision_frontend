import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/Constants/image_paths.dart';
import 'package:lungv_app/common/profile_card_w.dart';
import 'package:lungv_app/common/user_profile.dart';
import 'package:lungv_app/providers/Auth/user_provider.dart';
import 'package:lungv_app/services/auth_service.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Automatically fetch user data when the screen is loaded
    Future.microtask(() => ref.refresh(userProvider));
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: userAsync.when(
          data: (user) {
            if (user == null) {
              return const Text('No user data available');
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: UserProfile(imagePath: ImagePath.profileImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    'Account Information',
                    style: AppTextStyles.normal2,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      ProfileCardW(
                        prefixIcon: Icons.person,
                        title: 'Name',
                        subtitle: user.name ?? 'N/A',
                        onTap: () {},
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.email,
                        title: 'Email',
                        subtitle: user.email,
                        onTap: () {},
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.lock,
                        title: 'Change Password',
                        subtitle: "*******",
                        onTap: () {},
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.settings,
                        title: 'Theme',
                        subtitle: "System",
                        onTap: () {},
                        trailingIcon: Icons.edit,
                      ),
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
                        subtitle: "Tap to log out",
                        onTap: () async {
                          await logoutUser(ref);
                          if (context.mounted) {
                            context.go('/login');
                          }
                        },
                        trailingIcon: Icons.arrow_forward,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error:
              (e, _) => const Center(
                child: Text('Error occurred loading user profile'),
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
