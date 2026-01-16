import 'package:flutter/material.dart';

class OnboardingStepLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isNextDisabled;
  final bool isLastStep;

  const OnboardingStepLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.onNext,
    this.onBack,
    this.isNextDisabled = false,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937), // gray-800
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280), // gray-500
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          child,
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: onBack != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (onBack != null)
                TextButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Back'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4B5563), // gray-600
                    backgroundColor: const Color(0xFFF3F4F6), // gray-100
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: isNextDisabled ? null : onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD97706), // amber-600
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFFCD34D), // amber-300
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(isLastStep ? 'Finish' : 'Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
