import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:lungv_app/Themes/colors.dart';

void configLoading() {
  EasyLoading.instance
    ..indicatorType =
        EasyLoadingIndicatorType
            .ring // Sleek loading animation
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = AppColor.blackWithOpacity50
    ..backgroundColor = AppColor.blackWithOpacity50
    ..indicatorColor =
        Colors
            .blueAccent // Eye-catching indicator color
    ..textColor = Colors.black
    ..progressColor = Colors.blueAccent
    ..animationDuration = const Duration(milliseconds: 400)
    ..boxShadow = [
      BoxShadow(
        color: AppColor.blackWithOpacity50,
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ]
    ..textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
    ..contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
    ..dismissOnTap = false;
}

// Function for showing success messages with custom style
void showSuccessMessage(String message) {
  EasyLoading.showSuccess(
    message,
    duration: const Duration(seconds: 2),
    maskType: EasyLoadingMaskType.clear, // Allow user interaction
    dismissOnTap: true,
  );
}

// Function for showing error messages with custom style
void showErrorMessage(String message) {
  EasyLoading.showError(
    message,
    duration: const Duration(seconds: 3),
    maskType: EasyLoadingMaskType.black,
    dismissOnTap: true,
  );
}

void showLoading(String message) {
  EasyLoading.show(
    status: message,
    maskType: EasyLoadingMaskType.custom,
    dismissOnTap: false,
  );
}
