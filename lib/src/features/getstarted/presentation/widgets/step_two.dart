import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'feature_tile.dart';

class StepTwo extends StatelessWidget {
  final VoidCallback onNext;
  const StepTwo({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text('PLAN YOUR MEALS',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: primaryColor, fontFamily: 'Winslow')),
          const SizedBox(height: 8),
          Text(
            'Get Your Ideas Ready In Just A Minute With Generative AI!',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 15)],
            ),
            child: const Column(
              children: [
                FeatureTile(
                    icon: Icons.lightbulb_outline,
                    title: 'Tell Us What You Like',
                    subtitle:
                    'We take the guesswork out of meal planning by intelligently interpreting your tastes.'),
                SizedBox(height: 24),
                FeatureTile(
                    icon: Icons.tune,
                    title: 'Set Your Preferences',
                    subtitle:
                    'Your plan, your rules. Customize based on dietary needs, budget, and more.'),
                SizedBox(height: 24),
                FeatureTile(
                    icon: Icons.auto_awesome,
                    title: 'Get AI-Powered Ideas',
                    subtitle:
                    'Meal.io acts as your personal culinary assistant. Simply ask for a meal plan.'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onNext,
            child: Text(
              'Next',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}