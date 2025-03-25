import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/Constants/image_paths.dart';
import 'package:lungv_app/common/profile_card_w.dart';
import 'package:lungv_app/common/reusable_bottom_sheet.dart';
import 'package:lungv_app/common/user_profile.dart';
import 'package:lungv_app/providers/get_user_data.dart';
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
    Future.microtask(() => ref.refresh(getUserProvider));
  }

  void _openBottomSheet({
    required String title,
    required String fieldKey,
    required String hintText,
    TextInputType inputType = TextInputType.text,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => UpdateFieldBottomSheet(
            title: title,
            fieldKey: fieldKey,
            hintText: hintText,
            inputType: inputType,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(getUserProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: userAsync.when(
          data: (user) {
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
                        subtitle: user.name,
                        onTap:
                            () => _openBottomSheet(
                              title: 'Name',
                              fieldKey: 'name',
                              hintText: 'Enter your name',
                            ),
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.email,
                        title: 'Email',
                        subtitle: user.email,
                        onTap:
                            () => _openBottomSheet(
                              title: 'Email',
                              fieldKey: 'email',
                              hintText: 'Enter your email',
                              inputType: TextInputType.emailAddress,
                            ),
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.male,
                        title: 'Gender',
                        subtitle: user.gender,
                        onTap:
                            () => _openBottomSheet(
                              title: 'Gender',
                              fieldKey: 'gender',
                              hintText: 'Enter gender (M/F)',
                            ),
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.calendar_month,
                        title: 'Year of Birth',
                        subtitle: user.YOB,
                        onTap:
                            () => _openBottomSheet(
                              title: 'Year of Birth',
                              fieldKey: 'YOB',
                              hintText: 'Enter year (e.g. 2000)',
                              inputType: TextInputType.number,
                            ),
                        trailingIcon: Icons.edit,
                      ),
                      ProfileCardW(
                        prefixIcon: Icons.lock,
                        title: 'Change Password',
                        subtitle: "*******",
                        onTap:
                            () => _openBottomSheet(
                              title: 'Password',
                              fieldKey: 'password',
                              hintText: 'Enter new password',
                            ),
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
