import 'package:flutter/material.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/features/authentication/presentation/models/user.dart';
import 'package:mealio/src/features/authentication/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _logout() async {
    try {
      await AuthService().logout();
    } catch (e) {
      // Already handled in service, but good to catch just in case
      print("Logout error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome back, ${widget.user.firstname} ${widget.user.lastname}!", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text("Your email: ${widget.user.email}"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await _logout();
                router.go('/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
