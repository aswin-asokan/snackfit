import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 16,
            children: [
              Icon(icon),
              Text(label, style: context.textTheme.bodyMedium),
            ],
          ),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
