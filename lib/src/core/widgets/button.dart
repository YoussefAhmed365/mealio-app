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

  // Properties for border customization
  final Color? borderColor;
  final double? borderWidth;

  // New property for shadow customization
  final Color? shadowColor;

  const Button({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.fontSize,
    this.type = ButtonType.primary,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isFullWidth = true,
    this.elevation,
    this.padding,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? const EdgeInsets.symmetric(vertical: 14);
    final effectiveShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    // Determine default colors based on button type
    final Color defaultPrimaryColor = AppColors.amber600;
    final Color defaultTextColor = type == ButtonType.primary ? Colors.white : defaultPrimaryColor;

    // Effective colors passed by user or defaults
    final Color effectiveBackgroundColor = backgroundColor ?? defaultPrimaryColor;
    final Color effectiveForegroundColor = textColor ?? defaultTextColor;

    // Determine Border Configuration
    Color? effectiveBorderColor;
    double effectiveBorderWidth = borderWidth ?? 1.0;

    if (type == ButtonType.outline) {
      effectiveBorderColor = borderColor ?? effectiveBackgroundColor;
    } else {
      effectiveBorderColor = borderColor; // Can be null for primary/text buttons
    }

    BorderSide? borderSide;
    if (effectiveBorderColor != null || borderWidth != null) {
      borderSide = BorderSide(
        color: effectiveBorderColor ?? Colors.transparent,
        width: effectiveBorderWidth,
      );
    }

    Widget buttonContent = isLoading
        ? SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: effectiveForegroundColor,
        strokeWidth: 2,
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(
          text,
          style: fontSize != null
              ? fontSize?.copyWith(color: effectiveForegroundColor)
              : TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: effectiveForegroundColor,
          ),
        ),
      ],
    );

    Widget buttonWidget;

    switch (type) {
      case ButtonType.primary:
        buttonWidget = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            padding: effectivePadding,
            shape: effectiveShape,
            backgroundColor: effectiveBackgroundColor,
            foregroundColor: effectiveForegroundColor,
            elevation: elevation,
            shadowColor: shadowColor, // Apply shadow color
            side: borderSide,
            disabledBackgroundColor: effectiveBackgroundColor.withOpacity(onPressed == null ? 0.5 : 1.0),
            disabledForegroundColor: effectiveForegroundColor.withOpacity(0.6),
          ),
          child: buttonContent,
        );
        break;

      case ButtonType.outline:
        buttonWidget = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding: effectivePadding,
            shape: effectiveShape,
            foregroundColor: effectiveForegroundColor,
            side: borderSide,
            elevation: elevation,
            shadowColor: shadowColor, // Apply shadow color (visible if elevation > 0)
            disabledForegroundColor: effectiveForegroundColor.withOpacity(0.6),
          ).copyWith(
            side: MaterialStateProperty.resolveWith((states) {
              Color targetColor = effectiveBorderColor ?? effectiveBackgroundColor;
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(color: targetColor.withOpacity(0.3), width: effectiveBorderWidth);
              }
              return BorderSide(color: targetColor, width: effectiveBorderWidth);
            }),
          ),
          child: buttonContent,
        );
        break;

      case ButtonType.text:
        buttonWidget = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            padding: effectivePadding,
            shape: effectiveShape,
            foregroundColor: effectiveForegroundColor,
            side: borderSide,
            elevation: elevation, // Usually 0 for text buttons, but can be set
            shadowColor: shadowColor, // Apply shadow color
            disabledForegroundColor: effectiveForegroundColor.withOpacity(0.6),
          ),
          child: buttonContent,
        );
        break;
    }

    return isFullWidth
        ? SizedBox(width: double.infinity, child: buttonWidget)
        : buttonWidget;
  }
}