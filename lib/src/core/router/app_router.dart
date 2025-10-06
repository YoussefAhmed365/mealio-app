import 'package:go_router/go_router.dart';
import 'package:mealio/src/features/home/presentation/screens/onboarding.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/signup_screen.dart';

// Create a GoRouter instance
final GoRouter router = GoRouter(
  // Initial location of the app
  initialLocation: '/',
  // Define the routes
  routes: [
    GoRoute(path: '/', name: 'onboarding', builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: '/signup', name: 'signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginScreen()),
  ],
);