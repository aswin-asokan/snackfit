import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';
import 'package:frontend/shared/widgets/custom_button.dart';

class CaptureSection extends StatelessWidget {
  const CaptureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Serve us your look!", style: context.textTheme.titleLarge),
            Text(
              "Because you’re what you eat…",
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        CustomButton(
          bgColor: const Color(0xffEB2933),
          labelColor: const Color(0xffffffff),
          label: "Upload a Photo",
          onPress: () {},
        ),
        CustomButton(
          bgColor: const Color(0xffF5F0F0),
          labelColor: const Color(0xff000000),
          label: "Capture a Photo",
          onPress: () {},
        ),
      ],
    );
  }
}
