import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';
import '../widgets/custom_auth_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 30),
            child: Row(
              children: [
                Text(
                  'Meal',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: primaryColor, fontWeight: FontWeight.w700),
                ),
                Text(
                  '.io',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.brown[700], fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight,
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Text("Sign In", style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 10),
                  Text("Hi, welcome back! You've missed", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor)),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const CustomAuthTextField(labelText: "Email"),
                        const SizedBox(height: 20),
                        const CustomAuthTextField(labelText: "Password"),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              router.push('/forgot-password');
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.amber.shade800, decoration: TextDecoration.underline, decorationThickness: 2, decorationColor: Colors.amber.shade800),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 13)), backgroundColor: WidgetStateProperty.all<Color>(Colors.amber.shade800)),
                            child: Text(
                              "Sign In",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 18, fontVariations: <FontVariation>[FontVariation('wght', 700)]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Divider(color: Colors.grey.shade400)),
                            const SizedBox(width: 10),
                            Text("Or sign in with", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400)),
                            const SizedBox(width: 10),
                            Expanded(child: Divider(color: Colors.grey.shade400)),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/icons/google-icon.svg', width: 30, height: 30),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(width: 20),
                            IconButton.outlined(
                              onPressed: () {},
                              icon: SvgPicture.asset('assets/icons/microsoft-icon.svg', width: 30, height: 30),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(width: 20),
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(Icons.facebook, size: 30),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                router.push('/signup');
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.amber.shade800, decoration: TextDecoration.underline, decorationThickness: 2, decorationColor: Colors.amber.shade800),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
