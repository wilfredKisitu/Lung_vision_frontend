import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/models/login_user.dart';
import 'package:lungv_app/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthNotifier extends StateNotifier<AsyncValue<Auth?>> {
  final AuthService authService;
  AuthNotifier(this.authService) : super(const AsyncValue.data(null));

  // Method to login user
  Future<void> login(String email, String password) async {
    EasyLoading.show(status: 'Logging in user...');
    state = const AsyncValue.loading();
    try {
      final loggedInUser = await authService.loginUser(email, password);
      state = AsyncValue.data(loggedInUser);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('User logged in successfully!');
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }

  // Method to load user data (e.g., after app restart)
  Future<void> loadAuthData() async {
    state = const AsyncValue.loading();
    try {
      final loadedData = await authService.loadAuthData();
      state = AsyncValue.data(loadedData);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Provider for the AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<Auth?>>((
  ref,
) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
