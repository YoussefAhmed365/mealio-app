import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFFFBEB)
              : Colors.white, // amber-50
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD97706)
                : Colors.grey.shade300, // amber-600 vs gray-200
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? const Color(0xFFB45309)
                  : Colors.grey.shade700, // amber-700 vs gray-700
            ),
          ),
        ),
      ),
    );
  }
}
