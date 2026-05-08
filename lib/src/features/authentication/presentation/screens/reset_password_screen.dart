import 'package:flutter/material.dart';
import 'package:mealio/src/core/services/auth_service.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/features/authentication/presentation/widgets/custom_auth_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: Row(
                children: [
                  Text(
                    'Meal',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.amber600,
                      fontVariations: <FontVariation>[
                        FontVariation('wght', 700),
                      ],
                    ),
                  ),
                  Text(
                    '.io',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.brown[700],
                      fontVariations: <FontVariation>[
                        FontVariation('wght', 700),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Reset your password",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Remeber your new password",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: CustomAuthTextField(
                labelText: "Password",
                controller: _passwordController,
                isPassword: true,
              ),
            ),
            const SizedBox(height: 20),
            Button(
              text: "Change Password",
              onPressed: () async {
                final form = _formKey.currentState!;
                if (form.validate()) {
                  try {
                    await AuthService().resetPassword(
                      widget.email,
                      widget.otp,
                      _passwordController.text,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password changed successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      router.go('/login');
                    }
                  } on Exception catch (e) {
                    final errorMessage = e.toString().replaceFirst(
                      'Exception: ',
                      '',
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
