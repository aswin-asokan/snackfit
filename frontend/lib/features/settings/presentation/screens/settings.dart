import 'package:flutter/material.dart';
import 'package:frontend/features/settings/presentation/widgets/about_section.dart';
import 'package:frontend/features/settings/presentation/widgets/help_section.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        titleSpacing: 0,
        title: Text("Settings", style: context.textTheme.displayLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            const HelpSection(),
            const SizedBox(height: 30),
            const AboutSection(),
          ],
        ),
      ),
    );
  }
}
