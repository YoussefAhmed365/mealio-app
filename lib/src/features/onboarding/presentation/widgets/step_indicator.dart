import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Preferences",
      "Household",
      "Allergies",
      "Budget",
      "Tracking",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isCompletedOrCurrent = currentStep >= index;
          final isCurrent = currentStep == index;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompletedOrCurrent
                              ? const Color(0xFFD97706) // amber-600
                              : Colors.grey.shade200,
                          border: isCurrent
                              ? Border.all(
                                  color: const Color(0xFFFDE68A),
                                  width: 4,
                                ) // amber-300 ring
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isCompletedOrCurrent
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        steps[index],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isCompletedOrCurrent
                              ? const Color(0xFFD97706)
                              : Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ), // Align with circle center approx
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: currentStep > index
                            ? const Color(0xFFD97706)
                            : Colors.grey.shade200,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
