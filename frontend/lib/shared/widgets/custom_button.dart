import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.bgColor,
    required this.labelColor,
    required this.label,
    required this.onPress,
  });
  final Color labelColor;
  final Color bgColor;
  final String label;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(bgColor),
        ),
        child: Text(
          label,
          style: context.textTheme.bodyMedium!.copyWith(
            color: labelColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
