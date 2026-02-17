import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      "question": "How do I capture an image?",
      "answer":
          "Use the capture section on the Home screen to take a photo or select an image.",
    },
    {
      "question": "What does the app do with my image?",
      "answer":
          "It analyzes the clothing colors and patterns, then suggests a fun food comparison based on your outfit.",
    },
    {
      "question": "Where is the suggestion data saved?",
      "answer":
          "All suggestions are saved locally on your device using SQLite and displayed on the Home screen.",
    },
    {
      "question": "How do I set my API key?",
      "answer":
          "Go to the Settings screen and enter your API key to enable AI-powered suggestions.",
    },
    {
      "question": "Can I search for food locations nearby?",
      "answer":
          "Yes, after getting a suggestion, tap the “Near me Locations” button to search Google for places near you.",
    },
    {
      "question": "Is my API key stored securely?",
      "answer":
          "The API key is stored locally on your device in an encrypted database (SQLite).",
    },
    {
      "question": "What if I encounter an error?",
      "answer":
          "Check that your API key is correctly set in Settings and you have an internet connection.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: context.textTheme.displayLarge),
        scrolledUnderElevation: 0.0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  faq["question"]!,
                  style: context.textTheme.displayLarge,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      faq["answer"]!,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
