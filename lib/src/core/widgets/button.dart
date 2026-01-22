import 'package:flutter/material.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

enum ButtonType { primary, outline, text }

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final TextStyle? fontSize;
  final ButtonType type;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final bool isFullWidth;
  final double? elevation;
  final EdgeInsetsGeometry? padding;

  const Button({super.key, required this.text, this.onPressed, this.isLoading = false, this.fontSize, this.type = ButtonType.primary, this.borderRadius = 12.0, this.backgroundColor, this.textColor, this.icon, this.isFullWidth = true, this.elevation, this.padding});

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(vertical: 14);
    final effectiveShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    Widget buttonContent = isLoading
        ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: type == ButtonType.primary ? Colors.white : (textColor ?? AppColors.amber600), strokeWidth: 2))
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(
                text,
                style: fontSize != null ? fontSize?.copyWith(color: textColor ?? (type == ButtonType.primary ? Colors.white : AppColors.amber600)) : TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor ?? (type == ButtonType.primary ? Colors.white : AppColors.amber600)),
              ),
            ],
          );

    Widget buttonWidget;

    switch (type) {
      case ButtonType.primary:
        buttonWidget = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(padding: effectivePadding, shape: effectiveShape, backgroundColor: backgroundColor ?? AppColors.amber600, elevation: elevation),
          child: buttonContent,
        );
        break;
      case ButtonType.outline:
        buttonWidget = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding: effectivePadding,
            shape: effectiveShape,
            side: BorderSide(color: backgroundColor ?? AppColors.amber600),
            elevation: elevation,
          ),
          child: buttonContent,
        );
        break;
      case ButtonType.text:
        buttonWidget = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(padding: effectivePadding, shape: effectiveShape),
          child: buttonContent,
        );
        break;
    }

    return isFullWidth ? SizedBox(width: double.infinity, child: buttonWidget) : buttonWidget;
  }
}
