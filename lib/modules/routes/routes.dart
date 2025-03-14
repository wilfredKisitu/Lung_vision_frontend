// Define GoRouter
import 'package:go_router/go_router.dart';
import 'package:lungv_app/modules/Auth/auth.dart';
import 'package:lungv_app/modules/Details/details_screen.dart';
import 'package:lungv_app/modules/Main/navigation.dart';
import 'package:lungv_app/modules/Splash/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', // Set initial route
  routes: [
    GoRoute(path: '/main', builder: (context, state) => BottomNavBar()),
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(
      path: '/details/:id', // Route with dynamic parameter
      builder: (context, state) {
        final String? id = state.pathParameters['id'];
        return DetailsScreen(diagnosisId: id!); // Pass ID to details screen
      },
    ),
    // GoRoute(path: '/details', builder: (context, state) => DetailsScreen()),
  ],
);
