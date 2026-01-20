import 'package:flutter/material.dart';
import 'package:mealio/src/features/onboarding/presentation/providers/onboarding_state.dart';

class OnboardingController extends ChangeNotifier {
  int _currentStep = 0;
  OnboardingState _onboardingData = OnboardingState();

  int get currentStep => _currentStep;
  OnboardingState get onboardingData => _onboardingData;
  int get totalSteps => 5;

  void updateData(OnboardingState newData) {
    _onboardingData =
        newData; // Note: In a real immutable flow we'd use copyWith inside here or pass a partial object.
    // However, since we are passing a full new state or handling logic in UI, let's refine this.
    // Better pattern: The UI calls specific update methods or passes a modified copy.
    // For simplicity matching React 'updateData':
    notifyListeners();
  }

  void updatePreferences(String preferences) {
    _onboardingData = _onboardingData.copyWith(preferences: preferences);
    notifyListeners();
  }

  void updatePersons(int persons) {
    // When persons change, we might need to clean up allergies for removed persons?
    // React logic:
    // Ensure allergy data matches number of people
    // Clean up data for people who were removed

    Map<int, List<String>> newAllergies = Map.from(_onboardingData.allergies);

    // Ensure keys exist
    for (int i = 0; i < persons; i++) {
      if (!newAllergies.containsKey(i)) {
        newAllergies[i] = [];
      }
    }
    // Remove keys if > persons (indices start at 0)
    newAllergies.removeWhere((key, value) => key >= persons);

    _onboardingData = _onboardingData.copyWith(
      persons: persons,
      allergies: newAllergies,
    );
    notifyListeners();
  }

  void updateAllergies(int personIndex, String allergy) {
    // Toggle allergy
    Map<int, List<String>> currentAllergies = Map.from(
      _onboardingData.allergies,
    );
    List<String> personAllergies = List.from(
      currentAllergies[personIndex] ?? [],
    );

    if (allergy == 'No Allergies') {
      personAllergies.clear();
    } else {
      if (personAllergies.contains(allergy)) {
        personAllergies.remove(allergy);
      } else {
        personAllergies.add(allergy);
      }
    }

    currentAllergies[personIndex] = personAllergies;
    _onboardingData = _onboardingData.copyWith(allergies: currentAllergies);
    notifyListeners();
  }

  void updateBudget(String budget) {
    _onboardingData = _onboardingData.copyWith(budget: budget);
    notifyListeners();
  }

  void updateTrackingOption(String option) {
    _onboardingData = _onboardingData.copyWith(trackingOption: option);
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }
}
