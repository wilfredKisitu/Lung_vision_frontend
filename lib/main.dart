import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lungv_app/modules/routes/routes.dart';

void main() {
  configLoading();
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true, // Set to false to disable
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return EasyLoading.init()(
          context,
          DevicePreview.appBuilder(context, child),
        );
      },
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false
    ..contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
    ..successWidget = Icon(Icons.check_circle, color: Colors.green, size: 40);
}
