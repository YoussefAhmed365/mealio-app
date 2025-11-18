import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';
import '../widgets/custom_auth_textfield.dart';
import '../models/signup_details.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isAgree = false;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _openTermsOfService() {
    // Implement navigation to the Terms of Service screen or URL.
    print('Navigating to Terms of Service...');
  }

  void _openPrivacyPolicy() {
    // Implement navigation to the Privacy Policy screen or URL.
    print('Navigating to Privacy Policy...');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ------------------------------------------------
  // Handling Data Validation & Security With The API
  // ------------------------------------------------

  // TODO: 1.In SignupScreen: After validating the form, make an API call to your backend with all the user details (firstName, lastName, email, password).
  // TODO: 2.Backend Logic: The backend receives the data, hashes the password, creates a user account with a status like "pending_verification", and then sends the OTP email to the user.
  // TODO: 3.Navigation: After the API call is successful, navigate to the OTP screen, passing only the email. You don't need the other details anymore on the client-side.
  // TODO: 4.In VerifyOTP: The user enters the OTP. Your "Verify" button then makes a second API call to the backend with the email and the entered OTP. The backend verifies the code and, if correct, activates the user's account.

  Future<void> _handleSignup(SignupDetails details) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text("Create Account", style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 10),
                    Text(
                      "Join us now and try Meal.io to see the magic in planning",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
                      textAlign: TextAlign.center,
                    ),
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
                                      controller: _firstNameController,
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
                                      controller: _lastNameController,
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
                          CustomAuthTextField(labelText: "Email", controller: _emailController),
                          const SizedBox(height: 10),
                          CustomAuthTextField(labelText: "Password", controller: _passwordController, isPassword: true),
                          const SizedBox(height: 5),
                          FormField<bool>(
                            initialValue: _isAgree,
                            builder: (state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckboxListTile(
                                    value: _isAgree,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isAgree = value ?? false;
                                        state.didChange(_isAgree);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: Colors.amber.shade800,
                                    title: RichText(
                                      text: TextSpan(
                                        text: "Agree with ",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Terms of Service",
                                            style: TextStyle(color: Colors.amber.shade800, decoration: TextDecoration.underline, decorationColor: Colors.amber.shade800),
                                            recognizer: TapGestureRecognizer()..onTap = _openTermsOfService,
                                          ),
                                          const TextSpan(text: " & "),
                                          TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(color: Colors.amber.shade800, decoration: TextDecoration.underline, decorationColor: Colors.amber.shade800),
                                            recognizer: TapGestureRecognizer()..onTap = _openPrivacyPolicy,
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: state.hasError ? Text(state.errorText!, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
                                  ),
                                ],
                              );
                            },
                            validator: (value) {
                              if (value == null || !value) {
                                return 'You must agree to the terms of service and privacy policy';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final form = _formKey.currentState!;
                                if (form.validate()) {
                                  final email = _emailController.text;

                                  // In SignupScreen's onPressed
                                  final details = SignupDetails(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    agreeToTerms: _isAgree,
                                  );

                                  router.push('/otp/$email', extra: details);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                backgroundColor: Colors.amber.shade800,
                              ),
                              child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
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
      ),
    );
  }
}
