import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mealio/src/core/services/auth_service.dart';
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';
import 'package:mealio/src/core/widgets/button.dart';

class VerifyOTP extends StatefulWidget {
  final String email;

  const VerifyOTP({super.key, required this.email});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _isOtpIncomplete = false;
  bool _isLoading = false;

  // --- Resend Timer Logic ---
  Timer? _timer;
  int _start = 60;
  bool _isResendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    startTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isResendButtonEnabled = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendButtonEnabled = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  /// --- API Call to Verify OTP ---
  Future<void> _verifyOtp() async {
    final String otp = _controllers.map((c) => c.text).join();
    final String email = widget.email;

    if (otp.length != 6) {
      setState(() => _isOtpIncomplete = true);
      return;
    }

    setState(() {
      _isLoading = true;
      _isOtpIncomplete = false;
    });

    try {
      await AuthService().verifyOtp(email, otp);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification Successful!'),
            backgroundColor: Colors.green,
          ),
        );
        // Pass map with email and OTP to next screen
        router.push('/reset-password', extra: {'email': email, 'otp': otp});
      }
    } catch (e) {
      if (mounted) {
        // Show specific error message from backend
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", "")),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// --- API Call to Resend OTP ---
  Future<void> _resendCode() async {
    final String email = widget.email;

    setState(() => _isLoading = true);

    try {
      await AuthService().sendOtp(email);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully'),
            backgroundColor: Colors.blue,
          ),
        );
        setState(() {
          _start = 60;
        });
        startTimer();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", "")),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Builds a single OTP input field.
  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _isOtpIncomplete ? Colors.red : Colors.grey.shade400,
              width: _isOtpIncomplete ? 2 : 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _isOtpIncomplete ? Colors.red : Colors.grey.shade400,
              width: _isOtpIncomplete ? 2 : 1,
            ),
          ),
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
          if (value.length > 1) {
            _handlePaste(value);
            return;
          }
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            if (_isOtpIncomplete) {
              setState(() => _isOtpIncomplete = false);
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  /// Handles pasting a code into the OTP fields.
  void _handlePaste(String pastedText) {
    if (_isOtpIncomplete) {
      setState(() => _isOtpIncomplete = false);
    }

    final String digitsOnly = pastedText.replaceAll(RegExp(r'[^0-9]'), '');
    final String otpCode = digitsOnly.length > 6
        ? digitsOnly.substring(0, 6)
        : digitsOnly;

    for (int i = 0; i < otpCode.length; i++) {
      _controllers[i].text = otpCode[i];
    }

    for (int i = otpCode.length; i < 6; i++) {
      _controllers[i].clear();
    }

    if (otpCode.isNotEmpty) {
      int focusIndex = otpCode.length - 1;
      if (focusIndex == 5) {
        FocusScope.of(context).unfocus();
      } else {
        FocusScope.of(context).requestFocus(_focusNodes[focusIndex + 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Row(
              children: [
                Text(
                  'Meal',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.amber600,
                    fontVariations: <FontVariation>[FontVariation('wght', 700)],
                  ),
                ),
                Text(
                  '.io',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.brown[700],
                    fontVariations: <FontVariation>[FontVariation('wght', 700)],
                  ),
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Verify Code',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Please enter the code we just sent to email",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => _buildOtpField(index),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Button(
                      type: ButtonType.text,
                      onPressed: _isResendButtonEnabled && !_isLoading
                          ? _resendCode
                          : null,
                      text: _isResendButtonEnabled
                          ? 'Resend Code'
                          : 'Resend Code in $_start s',
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        onPressed: _isLoading ? null : _verifyOtp,
                        text: 'Verify',
                        isLoading: _isLoading,
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
