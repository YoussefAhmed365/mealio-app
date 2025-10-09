import 'package:flutter/material.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

class VerifyOTP extends StatefulWidget {
  final String email;
  final Map<String, dynamic>? signupDetails;
  const VerifyOTP({super.key, required this.email, required this.signupDetails});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  // We need 6 controllers and 6 focus nodes for each OTP digit field.
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  // State to track if OTP is incomplete for showing an error.
  bool _isOtpIncomplete = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers and focus nodes.
    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());

    // You can now access the signupDetails here or in build method
    // For example:
    // final firstName = widget.signupDetails?['firstName'];
    // final password = widget.signupDetails?['password'];
    // print('VerifyOTP received - First Name: $firstName, Password: $password');
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes to free up resources.
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// Builds a single OTP input field.
  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        // Allow only numbers.
        keyboardType: TextInputType.number,
        // Center the text.
        textAlign: TextAlign.center,
        // Limit input to a single character.
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          // Hide the character counter.
          counterText: '',
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: _isOtpIncomplete ? Colors.red : Colors.grey.shade400, width: _isOtpIncomplete ? 2 : 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              BorderSide(color: _isOtpIncomplete ? Colors.red : Colors.grey.shade400, width: _isOtpIncomplete ? 2 : 1)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        onChanged: (value) {
          // First, check for a paste operation by seeing if the new value has more than one character.
          if (value.length > 1) {
            _handlePaste(value);
            return; // Stop processing to prevent single-character logic from interfering.
          }

          // Handle single digit entry and move focus to the next field.
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            // If user starts typing, remove any existing error state.
            if (_isOtpIncomplete) {
              setState(() => _isOtpIncomplete = false);
            }
          }
          // Handle deleting a digit and move focus to the previous field.
          else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  /// Handles pasting a code into the OTP fields.
  void _handlePaste(String pastedText) {
    // If the user pastes, clear any previous error state.
    if (_isOtpIncomplete) {
      setState(() => _isOtpIncomplete = false);
    }

    // Sanitize the pasted text to only include digits, and trim to 6 characters.
    final String digitsOnly = pastedText.replaceAll(RegExp(r'[^0-9]'), '');
    final String otpCode = digitsOnly.length > 6 ? digitsOnly.substring(0, 6) : digitsOnly;

    // Distribute the sanitized digits across the OTP fields.
    for (int i = 0; i < otpCode.length; i++) {
      _controllers[i].text = otpCode[i];
    }

    // Clear any remaining fields if the pasted code was less than 6 digits.
    for (int i = otpCode.length; i < 6; i++) {
      _controllers[i].clear();
    }

    // Move focus appropriately after the paste.
    if (otpCode.isNotEmpty) {
      int focusIndex = otpCode.length - 1;
      if (focusIndex == 5) {
        // If all fields are filled, unfocus to hide the keyboard for a better UX.
        FocusScope.of(context).unfocus();
      } else {
        // Otherwise, focus the next empty field.
        FocusScope.of(context).requestFocus(_focusNodes[focusIndex + 1]);
      }
    }
  }

  /// Gathers the entered OTP and shows a dialog.
  void _verifyOtp() {
    // Concatenate the text from all controllers.
    final String otp = _controllers.map((controller) => controller.text).join();

    // Check if the OTP is complete.
    if (otp.length == 6) {
      // Clear any previous error state.
      if (_isOtpIncomplete) setState(() => _isOtpIncomplete = false);
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('OTP Verified'),
              content: Text('The entered OTP is: $otp'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
            ),
      );
    } else {
      // If OTP is incomplete, set state to show red borders on all fields.
      setState(() => _isOtpIncomplete = true);
    }
  }

  @override
  Widget build(BuildContext context) {// You can access the data within the build method as well
    // final String? receivedFirstName = widget.signupDetails?['firstName'];
    // final String? receivedLastName = widget.signupDetails?['lastName'];
    // final String? receivedPassword = widget.signupDetails?['password'];
    // final bool? receivedAgreeToTerms = widget.signupDetails?['agreeToTerms'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 0,
              child: IconButton.outlined(
                onPressed: () {
                  router.go('/signup');
                },
                icon: const Icon(Icons.arrow_back),
                iconSize: 26,
                color: textColor,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Verify Code', style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    Text(
                      "Please enter the code we just sent to email",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: secondaryTextColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.email,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    // Build the 6 OTP fields using a Row.
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(6, (index) => _buildOtpField(index))),
                    const SizedBox(height: 28),
                    Text(
                      "Didn't receive OTP?",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: secondaryTextColor),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement resend code logic with a timer that disables the button on click.
                      },
                      child: const Text('Resend Code'),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.amber.shade800,
                        ),
                        child: const Text('Verify', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}