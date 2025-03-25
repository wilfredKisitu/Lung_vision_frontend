import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/models/user_response.dart';
import 'package:lungv_app/services/get_user.dart';

// Service provider
final userServiceProvider = Provider<UserDataService>((ref) {
  return UserDataService();
});

// FutureProvider to fetch user data
final getUserProvider = FutureProvider<User>((ref) async {
  final service = ref.read(userServiceProvider);
  return await service.getUserData();
});
