import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';
import '../widgets/custom_auth_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text("Create Account", style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 10),
                  Text("Join us now and try Meal.io to see the magic in planning", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor), textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("First Name", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontVariations: <FontVariation>[FontVariation('wght', 700)])),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), bottomLeft: Radius.circular(12.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), bottomLeft: Radius.circular(12.0)),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), bottomLeft: Radius.circular(12.0)),
                                        borderSide: BorderSide(color: primaryColor ?? Colors.amber, width: 2.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Last Name", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontVariations: <FontVariation>[FontVariation('wght', 700)])),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                                        borderSide: BorderSide(color: primaryColor ?? Colors.amber, width: 2.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const CustomAuthTextField(labelText: "Email"),
                        const SizedBox(height: 10),
                        const CustomAuthTextField(labelText: "Password"),
                        const SizedBox(height: 5),
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Divider(color: Colors.grey.shade400)),
                            const SizedBox(width: 10),
                            Text("Or sign up with", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400)),
                            const SizedBox(width: 10),
                            Expanded(child: Divider(color: Colors.grey.shade400)),
                          ],
                        ),
                        const SizedBox(height: 20),
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
                            Text("Already have an account?"),
                            TextButton(
                              onPressed: () {
                                router.go('/login');
                              },
                              child: Text(
                                "Sign In",
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