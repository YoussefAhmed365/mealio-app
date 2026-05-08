import 'package:flutter/material.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/features/authentication/presentation/widgets/custom_auth_textfield.dart';
import 'package:mealio/src/core/services/auth_service.dart';

class ConfirmEmailScreen extends StatefulWidget {
  final String? email;

  const ConfirmEmailScreen({super.key, this.email});

  @override
  State<StatefulWidget> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
            CustomAuthTextField(
              labelText: "Email",
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            Button(
              text: "Confirm",
              onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isEmpty) return;

                try {
                  await AuthService().sendOtp(email);
                  if (context.mounted) {
                    router.push('/verify-otp', extra: email);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString().replaceAll("Exception: ", ""),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
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
