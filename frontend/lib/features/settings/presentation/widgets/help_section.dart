import 'package:flutter/material.dart';
import 'package:frontend/features/settings/presentation/widgets/settings_item.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Text("Help", style: context.textTheme.titleSmall),
        SettingsItem(
          icon: Icons.question_mark_outlined,
          label: "FAQ",
          onTap: () {},
        ),
        SettingsItem(
          icon: Icons.mail_outline_outlined,
          label: "Contact Support",
          onTap: () {},
        ),
      ],
    );
  }
}
