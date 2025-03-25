import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/services/update_user.dart';

final userUpdateServiceProvider = Provider<UserUpdateService>((ref) {
  return UserUpdateService();
});

final updateUserFieldProvider =
    FutureProvider.family<void, Map<String, dynamic>>((ref, fieldData) async {
      final service = ref.read(userUpdateServiceProvider);
      await service.updateUserField(fieldData);
    });
