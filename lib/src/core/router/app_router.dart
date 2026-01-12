import 'package:go_router/go_router.dart';
import 'package:mealio/src/features/authentication/presentation/models/user.dart';
import 'package:mealio/src/features/getstarted/presentation/screens/get_started.dart';
import 'package:mealio/src/features/authentication/presentation/screens/login_screen.dart';

import 'package:mealio/src/features/authentication/presentation/screens/signup_screen.dart';
import 'package:mealio/src/features/authentication/presentation/screens/verify_otp.dart';
import 'package:mealio/src/features/dashboard/presentation/screens/home.dart';
import 'package:mealio/src/features/legal/presentation/screens/legal.dart';

// Create a GoRouter instance
final GoRouter router = GoRouter(
  // Initial location of the app
  initialLocation: '/',
  // Define the routes
  routes: [
    GoRoute(
      path: '/',
      name: 'getstarted',
      builder: (context, state) => const GetstartedScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/verify-otp',
      name: 'otp',
      builder: (context, state) {
        final email = state.extra as String?;
        return VerifyOTP(email: email);
      },
    ),
    GoRoute(
      path: '/legal/:navigation',
      name: 'legal',
      builder: (context, state) {
        final navigate = state.pathParameters['navigation']!;
        return LegalScreen(navigation: navigate);
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) {
        final user = state.extra as User;
        return HomeScreen(user: user);
      },
    ),
  ],
);
