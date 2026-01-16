class OnboardingState {
  final String? preferences;
  final int persons;
  final Map<int, List<String>> allergies;
  final String? budget;
  final String? trackingOption;

  OnboardingState({
    this.preferences,
    this.persons = 1,
    this.allergies = const {},
    this.budget,
    this.trackingOption,
  });

  OnboardingState copyWith({
    String? preferences,
    int? persons,
    Map<int, List<String>>? allergies,
    String? budget,
    String? trackingOption,
  }) {
    return OnboardingState(
      preferences: preferences ?? this.preferences,
      persons: persons ?? this.persons,
      allergies: allergies ?? this.allergies,
      budget: budget ?? this.budget,
      trackingOption: trackingOption ?? this.trackingOption,
    );
  }

  @override
  String toString() {
    return 'OnboardingState(preferences: $preferences, persons: $persons, allergies: $allergies, budget: $budget, trackingOption: $trackingOption)';
  }
}
