import 'package:flutter/material.dart';
import 'package:frontend/features/settings/presentation/widgets/settings_item.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openEmail(String emailAddress) async {
  final Uri emailUri = Uri(scheme: 'mailto', path: emailAddress);

  try {
    if (!await launchUrl(emailUri)) {
      throw 'Could not launch $emailUri';
    }
  } catch (e) {
    // You can handle the error here, for example, by showing a SnackBar
    // In a real app, you would show an error message to the user.
    debugPrint('Error launching email: $e');
  }
}

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
          onTap: () {
            Navigator.pushNamed(context, "/faq");
          },
        ),
        SettingsItem(
          icon: Icons.mail_outline_outlined,
          label: "Contact Support",
          onTap: () {
            openEmail('aswin_asokan@outlook.com');
          },
        ),
      ],
    );
  }
}
