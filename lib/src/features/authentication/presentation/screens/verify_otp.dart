import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mealio/src/core/router/app_router.dart';
import 'package:mealio/src/core/theme/app_theme.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

String _apiBaseUrl = dotenv.env['API_BASE_URL']!;
const String _verifyOtpEndpoint = '/verify-otp';
const String _resendOtpEndpoint = '/resend-otp';

class VerifyOTP extends StatefulWidget {
  final String? email;
  const VerifyOTP({super.key, this.email});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late TextEditingController _emailController;
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
    _emailController = TextEditingController(text: widget.email ?? '');
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
    _emailController.dispose();
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
    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (otp.length != 6) {
      setState(() => _isOtpIncomplete = true);
      return;
    }

    setState(() {
      _isLoading = true;
      _isOtpIncomplete = false;
    });

    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl$_verifyOtpEndpoint'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (mounted) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification Successful!'),
              backgroundColor: Colors.green,
            ),
          );
          router.go('/login');
        } else {
          final errorData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification Failed: ${errorData['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
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
    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl$_resendOtpEndpoint'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email}),
      );

      if (mounted) {
        final responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message']),
              backgroundColor: Colors.blue,
            ),
          );
          _start = 60;
          startTimer();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${responseData['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please check your connection.'),
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
            Positioned(
              top: 30,
              left: 0,
              child: IconButton.outlined(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    router.go('/login');
                  }
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
                    // Replaced Text widget with TextField
                    TextField(
                      controller: _emailController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                      ),
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
                    TextButton(
                      onPressed: _isResendButtonEnabled && !_isLoading
                          ? _resendCode
                          : null,
                      child: Text(
                        _isResendButtonEnabled
                            ? 'Resend Code'
                            : 'Resend Code in $_start s',
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Colors.amber.shade800,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
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

// import 'package:flutter/material.dart';
// import 'package:mealio/src/core/router/app_router.dart';
// import 'package:mealio/src/core/theme/app_theme.dart';
// import 'package:mealio/src/features/authentication/presentation/models/auth_details.dart';
//
// class VerifyOTP extends StatefulWidget {
//   final String email;
//   final SignupDetails? signupDetails;
//   const VerifyOTP({super.key, required this.email, required this.signupDetails});
//
//   @override
//   State<VerifyOTP> createState() => _VerifyOTPState();
// }
//
// class _VerifyOTPState extends State<VerifyOTP> {
//   // We need 6 controllers and 6 focus nodes for each OTP digit field.
//   late List<TextEditingController> _controllers;
//   late List<FocusNode> _focusNodes;
//
//   // State to track if OTP is incomplete for showing an error.
//   bool _isOtpIncomplete = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers and focus nodes.
//     _controllers = List.generate(6, (index) => TextEditingController());
//     _focusNodes = List.generate(6, (index) => FocusNode());
//
//     // Accessing data is now type-safe
//     // final firstName = widget.signupDetails?.firstName;
//   }
//
//   @override
//   void dispose() {
//     // Dispose all controllers and focus nodes to free up resources.
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     for (var focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }
//
//   /// Builds a single OTP input field.
//   Widget _buildOtpField(int index) {
//     return SizedBox(
//       width: 50,
//       height: 60,
//       child: TextField(
//         controller: _controllers[index],
//         focusNode: _focusNodes[index],
//         // Allow only numbers.
//         keyboardType: TextInputType.number,
//         // Center the text.
//         textAlign: TextAlign.center,
//         // Limit input to a single character.
//         maxLength: 1,
//         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         decoration: InputDecoration(
//           // Hide the character counter.
//           counterText: '',
//           contentPadding: const EdgeInsets.all(12),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide:
//               BorderSide(color: _isOtpIncomplete ? Colors.red : Colors.grey.shade400, width: _isOtpIncomplete ? 2 : 1)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide:
//               BorderSide(color: _isOtpIncomplete ? Colors.red : Colors.grey.shade400, width: _isOtpIncomplete ? 2 : 1)),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.blue, width: 2),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.red, width: 2),
//           ),
//         ),
//         onChanged: (value) {
//           // First, check for a paste operation by seeing if the new value has more than one character.
//           if (value.length > 1) {
//             _handlePaste(value);
//             return; // Stop processing to prevent single-character logic from interfering.
//           }
//
//           // Handle single digit entry and move focus to the next field.
//           if (value.isNotEmpty && index < 5) {
//             FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
//             // If user starts typing, remove any existing error state.
//             if (_isOtpIncomplete) {
//               setState(() => _isOtpIncomplete = false);
//             }
//           }
//           // Handle deleting a digit and move focus to the previous field.
//           else if (value.isEmpty && index > 0) {
//             FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
//           }
//         },
//       ),
//     );
//   }
//
//   /// Handles pasting a code into the OTP fields.
//   void _handlePaste(String pastedText) {
//     // If the user pastes, clear any previous error state.
//     if (_isOtpIncomplete) {
//       setState(() => _isOtpIncomplete = false);
//     }
//
//     // Sanitize the pasted text to only include digits, and trim to 6 characters.
//     final String digitsOnly = pastedText.replaceAll(RegExp(r'[^0-9]'), '');
//     final String otpCode = digitsOnly.length > 6 ? digitsOnly.substring(0, 6) : digitsOnly;
//
//     // Distribute the sanitized digits across the OTP fields.
//     for (int i = 0; i < otpCode.length; i++) {
//       _controllers[i].text = otpCode[i];
//     }
//
//     // Clear any remaining fields if the pasted code was less than 6 digits.
//     for (int i = otpCode.length; i < 6; i++) {
//       _controllers[i].clear();
//     }
//
//     // Move focus appropriately after the paste.
//     if (otpCode.isNotEmpty) {
//       int focusIndex = otpCode.length - 1;
//       if (focusIndex == 5) {
//         // If all fields are filled, unfocus to hide the keyboard for a better UX.
//         FocusScope.of(context).unfocus();
//       } else {
//         // Otherwise, focus the next empty field.
//         FocusScope.of(context).requestFocus(_focusNodes[focusIndex + 1]);
//       }
//     }
//   }
//
//   /// Gathers the entered OTP and shows a dialog.
//   void _verifyOtp() {
//     // Concatenate the text from all controllers.
//     final String otp = _controllers.map((controller) => controller.text).join();
//
//     // Check if the OTP is complete.
//     if (otp.length == 6) {
//       // Clear any previous error state.
//       if (_isOtpIncomplete) setState(() => _isOtpIncomplete = false);
//       showDialog(
//         context: context,
//         builder: (context) =>
//             AlertDialog(
//               title: const Text('OTP Verified'),
//               content: Text('The entered OTP is: $otp'),
//               actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
//             ),
//       );
//     } else {
//       // If OTP is incomplete, set state to show red borders on all fields.
//       setState(() => _isOtpIncomplete = true);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 30,
//               left: 0,
//               child: IconButton.outlined(
//                 onPressed: () {
//                   router.go('/signup');
//                 },
//                 icon: const Icon(Icons.arrow_back),
//                 iconSize: 26,
//                 color: textColor,
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10),
//               ),
//             ),
//             Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Verify Code', style: Theme
//                         .of(context)
//                         .textTheme
//                         .headlineLarge, textAlign: TextAlign.center),
//                     const SizedBox(height: 16),
//                     Text(
//                       "Please enter the code we just sent to email",
//                       style: Theme
//                           .of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: secondaryTextColor),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       widget.email,
//                       style: Theme
//                           .of(context)
//                           .textTheme
//                           .bodyLarge,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 48),
//                     // Build the 6 OTP fields using a Row.
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(6, (index) => _buildOtpField(index))),
//                     const SizedBox(height: 28),
//                     Text(
//                       "Didn't receive OTP?",
//                       style: Theme
//                           .of(context)
//                           .textTheme
//                           .bodyMedium
//                           ?.copyWith(color: secondaryTextColor),
//                       textAlign: TextAlign.center,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // TODO: Implement resend code logic with a timer that disables the button on click.
//                       },
//                       child: const Text('Resend Code'),
//                     ),
//                     const SizedBox(height: 28),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _verifyOtp,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                           backgroundColor: Colors.amber.shade800,
//                         ),
//                         child: const Text('Verify', style: TextStyle(fontSize: 18, color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
