// lib/features/suggestion/screens/suggestions.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';
import 'package:frontend/shared/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:frontend/features/suggestion/services/database_helper.dart';
import 'package:frontend/features/suggestion/models/suggestion_model.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key, required this.capturedImage});
  final File capturedImage;

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  String? suggestion;
  String? modifiedString;
  bool loading = true;
  String? apiKey;

  static const String geminiEndpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";

  @override
  void initState() {
    super.initState();
    _loadApiKeyAndAnalyzeImage();
  }

  Future<void> _loadApiKeyAndAnalyzeImage() async {
    apiKey = await SuggestionsDB.instance.getApiKey();
    if (apiKey == null) {
      setState(() {
        suggestion =
            "Error: API key not found. Please save it in the settings.";
        loading = false;
      });
      return;
    }
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    try {
      final bytes = await widget.capturedImage.readAsBytes();
      final base64Image = base64Encode(bytes);

      final prompt = """
Analyze the clothing in this image. 
Identify the dominant colors and any visible patterns. 
Then suggest a fun food comparison in the format:
"You look like a [food name] 🍽️"
""";

      final requestBody = {
        "contents": [
          {
            "parts": [
              {"text": prompt},
              {
                "inline_data": {"mime_type": "image/jpeg", "data": base64Image},
              },
            ],
          },
        ],
      };

      final response = await http.post(
        Uri.parse("$geminiEndpoint?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String rawText =
            data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ?? "";

        // Remove markdown bold (**)
        rawText = rawText.replaceAll('**', '');

        final rawSuggestion = rawText.trim().isNotEmpty
            ? rawText.trim()
            : "No suggestion found.";
        final extractedName = extractFoodName(rawSuggestion);
        final formattedName = extractedName != null
            ? toTitleCase(extractedName)
            : 'No food found.';

        // Save suggestion but no need to store image itself
        final model = SuggestionModel(
          title: formattedName,
          suggestion: rawSuggestion,
          date: DateTime.now().toIso8601String(),
        );
        await SuggestionsDB.instance.insertSuggestion(model.toJson());

        setState(() {
          suggestion = rawSuggestion;
          modifiedString = formattedName;
          loading = false;
        });
      } else {
        throw Exception("Gemini API error: ${response.body}");
      }
    } catch (e) {
      setState(() {
        suggestion = "Error: $e";
        loading = false;
      });
    }
  }

  String toTitleCase(String text) {
    if (text.isEmpty) {
      return '';
    }
    return text
        .split(' ')
        .map((word) {
          return word
              .split('-')
              .map((subWord) {
                if (subWord.isEmpty) return '';
                return subWord[0].toUpperCase() +
                    subWord.substring(1).toLowerCase();
              })
              .join('-');
        })
        .join(' ');
  }

  String? extractFoodName(String fullText) {
    final RegExp regExp = RegExp(r'You look like a (.*?) 🍽️');
    final match = regExp.firstMatch(fullText);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
    return null;
  }

  _launchURL() async {
    if (modifiedString == null) return;

    final encodedQuery = Uri.encodeComponent("$modifiedString near me");
    final Uri url = Uri.parse("https://www.google.com/search?q=$encodedQuery");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          "Here's Your Serving!",
          style: context.textTheme.displayLarge,
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modifiedString ?? 'No food found.',
                      style: context.textTheme.titleLarge!.copyWith(
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        widget.capturedImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      suggestion ?? "No suggestion available.",
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      bgColor: context.colorScheme.primary,
                      labelColor: context.colorScheme.onPrimary,
                      label: "Near me Locations",
                      onPress: _launchURL,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
