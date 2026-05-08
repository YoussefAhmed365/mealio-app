import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/widgets/button.dart';
import 'package:mealio/src/core/services/auth_service.dart';

class ResetScreen extends StatelessWidget {
  final String? email;

  const ResetScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 30,
              left: 0,
              child: IconButton.outlined(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    router.go('/login');
                  }
                },
                icon: HeroIcon(
                  HeroIcons.arrowLeft,
                  style: HeroIconStyle.outline,
                  color: textColor,
                ),
                iconSize: 26,
                color: textColor,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
            ),
            Text(
              "We will help you restore your account",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Just follow structures to reset your password",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 20),
            Button(
              text: "Reset Password",
              onPressed: () async {
                if (email != null) {
                  try {
                    await AuthService().sendOtp(email!);
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
                } else {
                  router.push("/confirm-email-reset");
                }
              },
            ),
            if (email != null)
              Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Is this your email? $email",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: secondaryTextColor),
                  ),
                  const SizedBox(height: 10),
                  Button(
                    text: "Change",
                    onPressed: () {
                      router.push('/confirm-email-reset', extra: email);
                    },
                    type: ButtonType.text,
                    textColor: secondaryTextColor,
                    isFullWidth: false,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
