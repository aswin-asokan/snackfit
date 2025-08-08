import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/widgets/capture_section.dart';
import 'package:frontend/features/suggestion/presentation/screens/suggestions.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _capturedImage;

  void _handleImageCaptured(File image) {
    setState(() {
      _capturedImage = image;
    });
    if (_capturedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Suggestions(capturedImage: _capturedImage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: context.textTheme.displayLarge),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          spacing: 18,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CaptureSection(onImageCaptured: _handleImageCaptured),
            Text(
              "Recent servings",
              style: context.textTheme.titleLarge!.copyWith(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
