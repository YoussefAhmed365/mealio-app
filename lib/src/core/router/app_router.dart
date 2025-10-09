import 'package:go_router/go_router.dart';
import 'package:mealio/src/features/getstarted/presentation/screens/get_started.dart';
import 'package:mealio/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:mealio/src/features/authentication/presentation/screens/signup_screen.dart';
import 'package:mealio/src/features/authentication/presentation/screens/verify_otp.dart';

// Create a GoRouter instance
final GoRouter router = GoRouter(
  // Initial location of the app
  initialLocation: '/',
  // Define the routes
  routes: [
    GoRoute(path: '/', name: 'getstarted', builder: (context, state) => const GetstartedScreen()),
    GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', name: 'signup', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/otp/:email',
      name: 'otp',
      builder: (context, state) {
        final email = state.pathParameters['email']!;
        final Map<String, dynamic>? signupDetails = state.extra as Map<String, dynamic>?;
        return VerifyOTP(email: email, signupDetails: signupDetails);
      },
    ),
  ],
);
