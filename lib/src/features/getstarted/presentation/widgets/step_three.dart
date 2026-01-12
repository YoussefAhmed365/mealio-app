import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class StepThree extends StatelessWidget {
  final VoidCallback onCreateAccount;
  const StepThree({super.key, required this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 15)],
            ),
            child: Column(
              children: [
                Icon(Icons.restaurant_menu, color: primaryColor, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Your Personalized Plan is Here!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'The AI will generate a tailored meal plan with all the meal details, including the name, description, and an enticing image.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/images/getstarted2.webp', width: MediaQuery.of(context).size.width, height: 300, fit: BoxFit.cover),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: onCreateAccount,
                  child: Text(
                    'Create Your Account',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
