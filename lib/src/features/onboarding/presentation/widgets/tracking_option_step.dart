import 'package:flutter/material.dart';
import 'package:mealio/src/features/onboarding/data/onboarding_controller.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/onboarding_step_layout.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/option_button.dart';

class TrackingOptionStep extends StatelessWidget {
  final OnboardingController controller;
  final VoidCallback onFinish;

  const TrackingOptionStep({
    super.key,
    required this.controller,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      "Track Calories",
      "Track Macros",
      "Track Ingredients",
      "No Tracking",
    ];

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return OnboardingStepLayout(
          title: "Tracking Preferences",
          subtitle: "Would you like to track your meals?",
          onNext: onFinish,
          onBack: controller.prevStep,
          isNextDisabled: controller.onboardingData.trackingOption == null,
          isLastStep: true,
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
                    isSelected:
                        controller.onboardingData.trackingOption == option,
                    onTap: () => controller.updateTrackingOption(option),
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
