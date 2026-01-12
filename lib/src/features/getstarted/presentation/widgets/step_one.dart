import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class StepOne extends StatelessWidget {
  final VoidCallback onNext;
  const StepOne({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(
            'FROM CRAVINGS TO CALENDAR, SEAMLESSLY',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor, fontFamily: 'Winslow'),
          ),
          const SizedBox(height: 8),
          Text(
            'Crafting Your Ideal Weekly Menu, Intelligently Designed',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Text(
            'Meal.io is a revolutionary application that harnesses the power of AI to learn your food preferences and generate personalized weekly meal plans.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
          ),
          const SizedBox(height: 28),
          // --- Image with overlay card ---
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset('assets/images/getstarted1.webp', fit: BoxFit.cover, height: 300, width: MediaQuery.of(context).size.width),
              ),
              Positioned(
                bottom: -40,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(26), blurRadius: 20, offset: const Offset(0, 10))],
                    border: Border.all(color: backgroundColor ?? Colors.white, width: 4),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '18k+',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: primaryColor, fontWeight: FontWeight.w800),
                      ),
                      Text('Awards Winning', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60), // Extra space for the card
          // --- Get Started Button ---
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              shadowColor: primaryColor?.withAlpha(128),
            ),
            onPressed: onNext,
            child: Text(
              'Get Started',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
