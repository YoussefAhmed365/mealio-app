import 'package:flutter/material.dart';
import 'package:mealio/src/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/onboarding_step_layout.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/option_button.dart';
// import icon assets if needed, simplified to Icons.person for now

class FoodAllergiesStep extends StatefulWidget {
  final OnboardingController controller;

  const FoodAllergiesStep({super.key, required this.controller});

  @override
  State<FoodAllergiesStep> createState() => _FoodAllergiesStepState();
}

class _FoodAllergiesStepState extends State<FoodAllergiesStep> {
  int? _openPersonIndex = 0;
  final List<String> _allergyOptions = [
    "Peanut",
    "Milk",
    "Egg",
    "Fish",
    "Soy",
    "Gluten",
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final persons = widget.controller.onboardingData.persons;
        final allergies = widget.controller.onboardingData.allergies;

        return OnboardingStepLayout(
          title: "Food Allergies",
          subtitle: "Specify allergies for each person in the household.",
          onNext: widget.controller.nextStep,
          onBack: widget.controller.prevStep,
          child: SizedBox(
            height:
                350, // Limit height to allow scrolling inner list or let it expand
            child: ListView.separated(
              itemCount: persons,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final personAllergies = allergies[index] ?? [];
                final isOpen = _openPersonIndex == index;

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _openPersonIndex = isOpen ? null : index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.amber.shade800,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Person ${index + 1}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (!isOpen) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        personAllergies.isNotEmpty
                                            ? personAllergies.join(', ')
                                            : "No Allergies",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Icon(
                                isOpen
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isOpen)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          2, // 3 columns as per react
                                      childAspectRatio: 2.5,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                itemCount: _allergyOptions.length,
                                itemBuilder: (context, optIndex) {
                                  final option = _allergyOptions[optIndex];
                                  return OptionButton(
                                    label: option,
                                    isSelected: personAllergies.contains(
                                      option,
                                    ),
                                    onTap: () => widget.controller
                                        .updateAllergies(index, option),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
                              OptionButton(
                                label: "No Allergies",
                                isSelected: personAllergies.isEmpty,
                                onTap: () => widget.controller.updateAllergies(
                                  index,
                                  'No Allergies',
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
