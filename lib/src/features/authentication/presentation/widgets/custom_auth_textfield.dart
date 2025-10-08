import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class CustomAuthTextField extends StatefulWidget {
  final String labelText;

  const CustomAuthTextField({super.key, required this.labelText});

  @override
  State<CustomAuthTextField> createState() => _CustomAuthTextFieldState();
}

class _CustomAuthTextFieldState extends State<CustomAuthTextField> {
  bool _isPasswordShown = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordShown = !_isPasswordShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontVariations: <FontVariation>[FontVariation('wght', 700)])),
        const SizedBox(height: 10),
        if (widget.labelText == "Password")
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ${widget.labelText}';
              }
              return null;
            },
            obscureText: !_isPasswordShown,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: primaryColor ?? Colors.amber, width: 2.0),
              ),
              suffixIcon: GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SvgPicture.asset(
                    _isPasswordShown ? 'assets/icons/eye-slash.svg' : 'assets/icons/eye.svg',
                    width: 20,
                    height: 20,
                    // يمكنك تغيير لون أيقونة الـ SVG من هنا إذا أردت
                    colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          )
        else
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ${widget.labelText}';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: primaryColor ?? Colors.amber, width: 2.0),
              ),
            ),
          ),
      ],
    );
  }
}
