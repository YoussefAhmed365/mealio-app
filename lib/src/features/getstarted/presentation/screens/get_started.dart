import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/step_one.dart';
import '../widgets/step_two.dart';
import '../widgets/step_three.dart';

class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  State<GetstartedScreen> createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16.0),
          child: Column(
            children: [
              // --- App Logo Header ---
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Meal',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '.io',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.brown[700],
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // --- Progress Indicator ---
              Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                          color: _currentPage >= index
                              ? primaryColor
                              : secondaryTextColor?.withAlpha(77),
                          borderRadius: BorderRadius.circular(2.0)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // --- Page View Content ---
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    StepOne(onNext: _nextPage),
                    StepTwo(onNext: _nextPage),
                    StepThree(
                      onCreateAccount: () {
                        router.go('/login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
