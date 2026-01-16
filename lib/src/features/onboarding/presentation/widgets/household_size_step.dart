import 'package:flutter/material.dart';
import 'package:mealio/src/features/onboarding/data/onboarding_controller.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/onboarding_step_layout.dart';

class HouseholdSizeStep extends StatelessWidget {
  final OnboardingController controller;

  const HouseholdSizeStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return OnboardingStepLayout(
          title: "Household Size",
          subtitle: "How many people will you be planning meals for?",
          onNext: controller.nextStep,
          onBack: controller.prevStep,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  icon: Icons.remove,
                  onTap: () {
                    final current = controller.onboardingData.persons;
                    if (current > 1) controller.updatePersons(current - 1);
                  },
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    Text(
                      '${controller.onboardingData.persons}',
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD97706), // amber-600
                      ),
                    ),
                    const Text(
                      'People',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                _buildButton(
                  icon: Icons.add,
                  onTap: () {
                    final current = controller.onboardingData.persons;
                    if (current < 10) controller.updatePersons(current + 1);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 30, color: Colors.grey.shade600),
      ),
    );
  }
}
