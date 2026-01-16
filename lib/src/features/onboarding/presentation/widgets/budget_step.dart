import 'package:flutter/material.dart';
import 'package:mealio/src/features/onboarding/data/onboarding_controller.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/onboarding_step_layout.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/option_button.dart';

class BudgetStep extends StatelessWidget {
  final OnboardingController controller;

  const BudgetStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final options = ["Low", "Medium", "High", "No Limit"];

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return OnboardingStepLayout(
          title: "Weekly Budget",
          subtitle: "What's your approximate weekly budget for groceries?",
          onNext: controller.nextStep,
          onBack: controller.prevStep,
          isNextDisabled: controller.onboardingData.budget == null,
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
                    isSelected: controller.onboardingData.budget == option,
                    onTap: () => controller.updateBudget(option),
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
