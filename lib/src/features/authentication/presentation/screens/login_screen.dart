import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/features/authentication/services/auth_service.dart';
import '../widgets/custom_auth_textfield.dart';
import '../models/auth_details.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignin(SigninCridentials credentials) async {
    try {
      final user = await AuthService().login(
        credentials.email,
        credentials.password,
      );

      if (user != null) {
        if (mounted) {
          router.go('/home', extra: user);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed: Unknown error')),
          );
        }
      }
    } catch (e) {
      print('Signin failed: $e');
      if (mounted) {
        final message = e.toString().replaceAll('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Signin failed: $message')));
      }
    }
  }

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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '.io',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.brown[700],
                    fontWeight: FontWeight.w700,
                  ),
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
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hi, welcome back! You've missed",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomAuthTextField(
                          labelText: "Email",
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20),
                        CustomAuthTextField(
                          labelText: "Password",
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              final email = _emailController.text.trim();
                              router.push('/verify-otp', extra: email);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.amber.shade800,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Colors.amber.shade800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final form = _formKey.currentState!;
                              if (form.validate()) {
                                final credentials = SigninCridentials(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                // Call the new handler method
                                await _handleSignin(credentials);
                              }
                            },
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(vertical: 13),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.amber.shade800,
                              ),
                            ),
                            child: Text(
                              "Sign In",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontVariations: <FontVariation>[
                                      FontVariation('wght', 700),
                                    ],
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(color: Colors.grey.shade400),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Or sign in with",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey.shade400),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Divider(color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/google-icon.svg',
                                width: 30,
                                height: 30,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 35,
                              ),
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton.outlined(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/microsoft-icon.svg',
                                width: 30,
                                height: 30,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 35,
                              ),
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(Icons.facebook, size: 30),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 35,
                              ),
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
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
                                style: TextStyle(
                                  color: Colors.amber.shade800,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  decorationColor: Colors.amber.shade800,
                                ),
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
