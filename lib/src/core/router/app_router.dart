import 'package:go_router/go_router.dart';
import 'package:mealio/src/features/authentication/domain/entities/user.dart';
import 'package:mealio/src/features/onboarding/presentation/screens/onboarding_screen.dart';
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
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return OnboardingScreen(user: user);
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
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
        final user = state.extra as UserEntity;
        return HomeScreen(user: user);
      },
    ),
    GoRoute(
      path: '/plans',
      name: 'Weekly Plans',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return HomeScreen(user: user);
      },
    ),
    GoRoute(
      path: '/recipes',
      name: 'Recipes',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return HomeScreen(user: user);
      },
    ),
    GoRoute(
      path: '/shoping-list',
      name: 'Shopping List',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return HomeScreen(user: user);
      },
    ),
    GoRoute(
      path: '/discover',
      name: 'Discover Recipes',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return HomeScreen(user: user);
      },
    ),
    GoRoute(
      path: '/analysis',
      name: 'Nutrition Analysis',
      builder: (context, state) {
        final user = state.extra as UserEntity;
        return HomeScreen(user: user);
      },
    ),
  ],
);
