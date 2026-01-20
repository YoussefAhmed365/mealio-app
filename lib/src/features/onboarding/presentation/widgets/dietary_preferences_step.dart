import 'package:flutter/material.dart';
import 'package:mealio/src/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/onboarding_step_layout.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/option_button.dart';

class DietaryPreferencesStep extends StatelessWidget {
  final OnboardingController controller;

  const DietaryPreferencesStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final options = [
      "No Preference",
      "Vegetarian",
      "Vegan",
      "Pescatarian",
      "Keto",
      "Paleo",
      "Gluten-Free",
    ];

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return OnboardingStepLayout(
          title: "Dietary Preferences",
          subtitle:
              "Select your dietary preference for more customized meal plans.",
          onNext: controller.nextStep,
          isNextDisabled: controller.onboardingData.preferences == null,
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return OptionButton(
                    label: option,
                    isSelected: controller.onboardingData.preferences == option,
                    onTap: () => controller.updatePreferences(option),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
