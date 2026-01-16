import 'package:flutter/material.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/features/authentication/presentation/models/user.dart';
import 'package:mealio/src/core/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            Button(
              onPressed: () async {
                await AuthService().logout();
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              text: "Logout",
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }
}
