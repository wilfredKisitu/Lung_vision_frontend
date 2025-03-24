import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lungv_app/Themes/colors.dart';
import 'package:lungv_app/Themes/text_styles.dart';
import 'package:lungv_app/common/custom_button.dart';
import 'package:lungv_app/common/custom_textfield.dart';
import 'package:lungv_app/models/login_user.dart';
import 'package:lungv_app/models/user_model.dart';
import 'package:lungv_app/providers/Auth/auth_provider.dart';
import 'package:lungv_app/providers/Auth/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColor.primaryWhite,
        // title: Image.asset('assets/images/small_logo_without_label.png', height: 40),
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.chevron_left, size: 24),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
              child: Text(
                'Welcome to LungVision',
                style: AppTextStyles.heading1,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 30, 20),
              child: Text(
                'Sign up or log in to assess your risk of developing lung cancer and take proactive steps for your health',
                style: AppTextStyles.heading2,
              ),
            ),
            SizedBox(height: 5),
            Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [Tab(text: "Login"), Tab(text: "Signup")],
                ),
                SizedBox(
                  height: 800, //
                  child: TabBarView(
                    controller: _tabController,
                    children: [LoginTab(), SignupTab()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Login Tab
class LoginTab extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginTab({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    /// Listen for state changes and show EasyLoading messages
    ref.listen<AsyncValue<Auth?>>(authProvider, (previous, next) {
      if (next.isLoading) {
        EasyLoading.show(status: 'Logging in user...');
      } else if (next.hasError) {
        EasyLoading.showError('Error: ${next.error}');
      } else if (next.hasValue && next.value != null) {
        EasyLoading.showSuccess('User Logged in: ${next.value!.userId}');

        if (ref.read(authProvider.notifier).mounted) {
          context.go('/main');
        }
      }
    });
    return Column(
      children: [
        SizedBox(height: 15),
        // Email
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 20, 18, 0),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              obscureText: false,
            ),
          ),
        ),
        SizedBox(height: 15),
        // Password
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
              prefixIcon: Icons.lock,
              obscureText: true,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot Password?',
                textAlign: TextAlign.left,
                style: AppTextStyles.normal14,
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: CustomButton(
              text: 'LOGIN',
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                authNotifier.login(email, password);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 30),
          child: Text(
            'By signing up you agree to our Terms of Service and Privacy Policy',
            style: AppTextStyles.normal16,
          ),
        ),
        // handling auth State
        authState.when(
          data: (auth) => Container(),
          loading: () => const SizedBox.shrink(),
          error: (error, stack) => Container(),
        ),
      ],
    );
  }
}

// SignUp Tab
class SignupTab extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController yearOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  SignupTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    // Listen for state changes and show EasyLoading messages
    ref.listen<AsyncValue<User?>>(userProvider, (previous, next) {
      if (next.isLoading) {
        EasyLoading.show(status: 'Creating user...');
      } else if (next.hasError) {
        EasyLoading.showError('Error: ${next.error}');
      } else if (next.hasValue && next.value != null) {
        EasyLoading.showSuccess('User Created: ${next.value!.name}');

        if (ref.read(userProvider.notifier).mounted) {
          context.go('/main');
        }
      }
    });

    return Column(
      children: [
        SizedBox(height: 15),
        _buildTextField(nameController, 'Enter your name', Icons.person),
        SizedBox(height: 10),
        _buildTextField(emailController, 'Enter your email', Icons.email),
        SizedBox(height: 10),
        _buildTextField(
          yearOfBirthController,
          'Year of Birth YYYY',
          Icons.calendar_month,
        ),
        SizedBox(height: 10),
        _buildTextField(genderController, 'Gender M / F', Icons.male),
        SizedBox(height: 10),
        _buildTextField(
          passwordController,
          'Enter your password',
          Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 10),
        _buildTextField(
          confirmPasswordController,
          'Confirm password',
          Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Center(
            child: CustomButton(
              text: 'Signup',
              onPressed: () {
                // Check if passwords match
                if (passwordController.text != confirmPasswordController.text) {
                  EasyLoading.showError('Passwords do not match');
                  return;
                }

                // Call API to create user
                final newUser = User(
                  name: nameController.text,
                  email: emailController.text,
                  yob: yearOfBirthController.text,
                  gender: genderController.text,
                  password: passwordController.text,
                );
                userNotifier.createUSer(newUser); // Correct method name here
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15, 10, 30),
          child: Text(
            'By signing up you agree to our Terms of Service and Privacy Policy',
            style: AppTextStyles.normal16,
          ),
        ),

        // Handle userState
        userState.when(
          data: (user) => Container(), // Success is handled by EasyLoading
          loading:
              () =>
                  const SizedBox.shrink(), // No need for a loading indicator, EasyLoading handles it
          error:
              (error, stack) => Container(), // Errors handled via EasyLoading
        ),
      ],
    );
  }

  // Helper method to create text fields for the form
  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool obscureText = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 10, 10, 0),
        child: CustomTextField(
          controller: controller,
          hintText: hintText,
          prefixIcon: icon,
          obscureText: obscureText,
        ),
      ),
    );
  }
}
