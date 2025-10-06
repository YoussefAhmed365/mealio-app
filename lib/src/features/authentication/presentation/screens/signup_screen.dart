import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Signup Screen', style: TextStyle(color: textColor)),
      ),
    );
  }
}