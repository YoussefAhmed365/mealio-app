import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Key for managing the form state
  final _formKey = GlobalKey<FormState>();

  // Controllers for managing form field state
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Always dispose of controllers to free up resources
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    image: const DecorationImage(image: AssetImage('assets/images/auth-bg.webp'), fit: BoxFit.cover),
                  ),
                  child: GlassmorphicContainer(
                    borderRadius: 16.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("— Meal.io —", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                          const SizedBox(height: 20),
                          Text("We are", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
                          const SizedBox(height: 10),
                          Text("Plan your meals.", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
                          const SizedBox(height: 10),
                          Text("10 million+ people joined our app, be one of them now", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                          const SizedBox(height: 40),
                          Stack(
                            children: [
                              Text(
                                "Powered with AI",
                                // نأخذ النمط الافتراضي ونعدّل عليه فقط
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      'Meal',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.amber[800], fontVariations: <FontVariation>[FontVariation('wght', 700.0)]),
                    ),
                    Text(
                      '.io',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.brown[700], fontVariations: <FontVariation>[FontVariation('wght', 700.0)]),
                    ),
                  ],
                ),
                Text("Welcome back!", style: Theme.of(context).textTheme.headlineLarge),
                Text("To keep connected with us please login with your personal info", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor)),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(controller: _emailController, labelText: 'Email', hintText: 'Your Email', keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 10),
                      CustomTextField(controller: _passwordController, labelText: 'Password', hintText: 'Your Password', obscureText: true),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Handle sign up logic here
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signing up...')));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[800],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                          child: const Text('Sign In', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    router.push('/restore-account');
                  },
                  child: Text(
                    "Forgot your password?",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.amber[800], decoration: TextDecoration.underline, decorationColor: Colors.amber[800], decorationThickness: 2.0),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: secondaryTextColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("OR", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: secondaryTextColor)),
                    ),
                    Expanded(child: Container(height: 1, color: secondaryTextColor)),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SocialSignButtons(icon: Icon(Icons.g_mobiledata, size: 26)),
                    const SizedBox(width: 10),
                    SocialSignButtons(icon: Icon(Icons.window, size: 26)),
                    const SizedBox(width: 10),
                    SocialSignButtons(icon: Icon(Icons.facebook, size: 26)),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text("Don't have an account?", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor)),
                    TextButton(
                      onPressed: () {
                        router.push('/signup');
                      },
                      child: Text(
                        "Create a new account",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.amber[800], decoration: TextDecoration.underline, decorationColor: Colors.amber[800], decorationThickness: 2.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double borderRadius;
  final Color color;
  final Color borderColor;
  final double borderWidth;

  const GlassmorphicContainer({super.key, required this.child, this.blur = 12.0, this.borderRadius = 16.0, this.color = Colors.white24, this.borderColor = Colors.white30, this.borderWidth = 2.5});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: child,
        ),
      ),
    );
  }
}

// --- Reusable Custom Text Field Widget ---
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({super.key, required this.controller, required this.labelText, required this.hintText, this.obscureText = false, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blueGrey[900])),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey[500]),
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.amber.shade800, width: 2.0),
            ),
          ),
          // You can add validators here
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class SocialSignButtons extends StatelessWidget {
  final Icon icon;

  const SocialSignButtons({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(16.0),
        ),
        child: icon,
      ),
    );
  }
}
