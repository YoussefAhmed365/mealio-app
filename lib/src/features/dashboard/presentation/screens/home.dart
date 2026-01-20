import 'package:flutter/material.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/features/authentication/domain/entities/user.dart';

import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentPageRoute: "/home",),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${widget.user.firstname} ${widget.user.lastname}!", style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        )
      ),
    );
  }
}

// Text("Name: ${widget.user.firstname} ${widget.user.lastname}!", style: Theme.of(context).textTheme.headlineMedium),
// Text("Email: ${widget.user.email}"),
// Button(
//  onPressed: () async {
//  await AuthService().logout();
//  },
//  icon: const Icon(Icons.logout, color: Colors.white),
//  text: "Logout",
//  isFullWidth: false,
// ),