import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/models/user_model.dart';
import 'package:lungv_app/services/user_service.dart';

class UserNotifier extends StateNotifier<AsyncValue<User?>> {
  final UserService userService;

  UserNotifier(this.userService) : super(const AsyncValue.data(null));

  Future<void> createUSer(User user) async {
    EasyLoading.show(status: 'Creating user...');
    state = AsyncValue.loading();
    try {
      final newUser = await userService.createUser(user);
      state = AsyncValue.data(newUser);
      EasyLoading.dismiss(); // Hide loading
      EasyLoading.showSuccess('User created successfully!'); // show success
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      EasyLoading.dismiss(); // Hide loading
      EasyLoading.showError(e.toString()); // Show error
    }
  }
}

final userServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User?>>((
  ref,
) {
  final userService = ref.watch(userServiceProvider);
  return UserNotifier(userService);
});
