import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/services/auth_service.dart';
import '../widgets/custom_auth_textfield.dart';
import '../models/auth_details.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _remember = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.amber600, fontWeight: FontWeight.w700),
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
                        CustomAuthTextField(labelText: "Email", controller: _emailController),
                        const SizedBox(height: 20),
                        CustomAuthTextField(labelText: "Password", controller: _passwordController, isPassword: true),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: FormField<bool>(
                                initialValue: _remember,
                                builder: (state) {
                                  return CheckboxListTile(
                                    value: _remember,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _remember = value ?? false;
                                        state.didChange(_remember);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,
                                    activeColor: AppColors.amber600,
                                    contentPadding: EdgeInsets.zero,
                                    title: RichText(
                                      text: TextSpan(
                                        text: "Remember me",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Button(
                              type: ButtonType.text,
                              text: "Forgot Password?",
                              fontSize: Theme.of(context).textTheme.labelLarge,
                              isFullWidth: false,
                              onPressed: () {
                                final email = _emailController.text.trim();
                                router.push('/verify-otp', extra: email);
                              },
                              textColor: Colors.amber.shade800,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: Button(
                            text: "Sign In",
                            onPressed: () async {
                              final form = _formKey.currentState!;
                              if (form.validate()) {
                                final credentials = SigninCridentials(email: _emailController.text, password: _passwordController.text, remember: _remember);
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  final user = await AuthService().login(credentials.email, credentials.password, credentials.remember);
                                  if (user != null && mounted) {
                                    router.go('/home', extra: user);
                                  }
                                } on Exception catch (e) {
                                  final errorMessage = e.toString().replaceFirst('Exception: ', '');
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(errorMessage),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                } finally {
                                  setState(() {
                                  _isLoading = false;
                                  });
                                }
                              }
                            },
                            isLoading: _isLoading,
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
                            const SizedBox(width: 3),
                            Button(
                              type: ButtonType.text,
                              text: "Sign Up",
                              fontSize: Theme.of(context).textTheme.labelLarge,
                              isFullWidth: false,
                              onPressed: () {
                                router.push('/signup');
                              },
                              textColor: Colors.amber.shade800,
                              padding: EdgeInsets.zero,
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