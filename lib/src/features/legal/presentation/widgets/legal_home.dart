import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LegalHome extends StatelessWidget {
  const LegalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Legal Information")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Privacy Policy"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/legal/Privacy'),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text("Terms of Use"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/legal/Terms'),
          ),
        ],
      ),
    );
  }
}
