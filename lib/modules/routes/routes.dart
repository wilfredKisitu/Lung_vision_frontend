import 'package:go_router/go_router.dart';
import 'package:lungv_app/models/Diagnosis/diagnosis_model.dart';
import 'package:lungv_app/modules/Auth/auth.dart';
import 'package:lungv_app/modules/CT_Details/ct_details_Screen.dart';
import 'package:lungv_app/modules/Details/details_screen.dart';
import 'package:lungv_app/modules/Main/navigation.dart';
import 'package:lungv_app/modules/Splash/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login', //
  routes: [
    GoRoute(path: '/main', builder: (context, state) => BottomNavBar()),
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        // final String? id = state.pathParameters['id'];
        final diagnosis = state.extra as Diagnosis?;
        final id = state.pathParameters['id']!;
        return DetailsScreen(diagnosisId: id, diagnosis: diagnosis);

        // return DetailsScreen(diagnosisId: id!);
      },
    ),
    GoRoute(
      path: '/detailsparsed/:id',
      builder: (context, state) {
        // final String? id = state.pathParameters['id'];
        final diagnosis = state.extra as Diagnosis;
        final id = state.pathParameters['id']!;
        return DetailsScreenParsed(diagnosisId: id, diagnosis: diagnosis);

        // return DetailsScreen(diagnosisId: id!);
      },
    ),
    GoRoute(
      path: '/ct_details',
      builder: (context, state) {
        final String? imageUrl = state.uri.queryParameters['imageUrl'];
        final String? prediction = state.uri.queryParameters['prediction'];
        final String? confidenceStr = state.uri.queryParameters['confidence'];
        final String? createdAt = state.uri.queryParameters['createdAt'];
        final double confidence =
            confidenceStr != null ? double.tryParse(confidenceStr) ?? 0.0 : 0.0;

        return CtDetailsScreen(
          imageUrl: imageUrl ?? '',
          prediction: prediction ?? '',
          confidence: confidence,
          createdAt: createdAt ?? '',
        );
      },
    ),
  ],
);
