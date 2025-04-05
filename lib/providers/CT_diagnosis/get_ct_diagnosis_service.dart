import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/services/ct_diagnosis_service.dart';
import 'package:lungv_app/models/ct_diagnosis.dart';

class CtDiagnoseNotifier extends StateNotifier<CtDiagnoseResult?> {
  final CtDiagnoseService _service;

  CtDiagnoseNotifier(this._service) : super(null);

  Future<void> uploadImage(File imageFile) async {
    final result = await _service.uploadCtImage(imageFile);
    state = result; // Update the state with the new result
  }
}

final ctDiagnoseProvider =
    StateNotifierProvider.autoDispose<CtDiagnoseNotifier, CtDiagnoseResult?>((
      ref,
    ) {
      return CtDiagnoseNotifier(CtDiagnoseService());
    });
