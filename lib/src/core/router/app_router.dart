import 'package:go_router/go_router.dart';
import 'package:mealio/src/features/home/presentation/screens/get_started.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/signup_screen.dart';

// Create a GoRouter instance
final GoRouter router = GoRouter(
  // Initial location of the app
  initialLocation: '/',
  // Define the routes
  routes: [
    GoRoute(path: '/', name: 'getstarted', builder: (context, state) => const GetstartedScreen()),
    GoRoute(path: '/signup', name: 'signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/login', name: 'login', builder: (context, state) => const LoginScreen()),
  ],
);