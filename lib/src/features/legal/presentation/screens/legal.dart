import 'package:flutter/material.dart';
import 'package:mealio/src/features/legal/presentation/widgets/legal_home.dart';
import 'package:mealio/src/features/legal/presentation/widgets/privacy_policy.dart';
import 'package:mealio/src/features/legal/presentation/widgets/terms_of_use.dart';

class LegalScreen extends StatefulWidget {
  final String navigation;
  final Map<String, Widget> legalScreens = {"LegalHome": const LegalHome(), "Privacy": const PrivacyPolicyScreen(), "Terms": const TermsOfUseScreen()};
  LegalScreen({super.key, required this.navigation});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.legalScreens[widget.navigation] ?? widget.legalScreens['Privacy']);
  }
}
