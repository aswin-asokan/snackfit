import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Text("About SnackFit", style: context.textTheme.titleSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Version", style: context.textTheme.bodyMedium),
            Text("1.0.0", style: context.textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
