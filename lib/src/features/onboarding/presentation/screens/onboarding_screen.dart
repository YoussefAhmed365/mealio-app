import 'package:flutter/material.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/services/auth_service.dart';
import 'package:mealio/src/features/authentication/domain/entities/user.dart';
import 'package:mealio/src/features/onboarding/presentation/providers/onboarding_controller.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/budget_step.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/dietary_preferences_step.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/food_allergies_step.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/household_size_step.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/step_indicator.dart';
import 'package:mealio/src/features/onboarding/presentation/widgets/tracking_option_step.dart';

class OnboardingScreen extends StatefulWidget {
  final UserEntity user;

  const OnboardingScreen({super.key, required this.user});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final OnboardingController _controller;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _controller = OnboardingController();
    _pageController = PageController();

    // Listen to controller steps to animate page
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (_pageController.hasClients &&
        _pageController.page?.round() != _controller.currentStep) {
      _pageController.animateToPage(
        _controller.currentStep,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleFinish() async {
    // Logic to save data would go here
    // In a real app, we'd map the data to the expected backend format
    debugPrint("Onboarding Complete: ${_controller.onboardingData}");

    await AuthService().completeOnboarding(_controller.onboardingData);

    if (mounted) {
      router.go('/home', extra: widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Or animated background if we port that too
      body: SafeArea(
        child: Column(
          children: [
            ListenableBuilder(
              listenable: _controller,
              builder: (context, _) => StepIndicator(
                currentStep: _controller.currentStep,
                totalSteps: _controller.totalSteps,
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: [
                  DietaryPreferencesStep(controller: _controller),
                  HouseholdSizeStep(controller: _controller),
                  FoodAllergiesStep(controller: _controller),
                  BudgetStep(controller: _controller),
                  TrackingOptionStep(
                    controller: _controller,
                    onFinish: _handleFinish,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
