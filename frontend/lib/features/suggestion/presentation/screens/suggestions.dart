import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key, required this.capturedImage});
  final File capturedImage;

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  String? suggestion;
  bool loading = true;

  static const String apiKey = "api";
  static const String geminiEndpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    try {
      // Convert image to Base64
      final bytes = await widget.capturedImage.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Create the prompt
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

      // Send request to Gemini
      final response = await http.post(
        Uri.parse("$geminiEndpoint?key=$apiKey"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];

        setState(() {
          suggestion = text?.trim() ?? "No suggestion found.";
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

  void _searchFood() async {
    if (suggestion == null) return;
    final query = Uri.encodeComponent(
      suggestion!.replaceAll("You look like a", "").trim(),
    );
    final url = Uri.parse("https://www.google.com/search?q=$query");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Here's Your Serving!")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.file(widget.capturedImage, height: 200),
                  const SizedBox(height: 20),
                  Text(
                    suggestion ?? "",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _searchFood,
                    child: const Text("Try it out"),
                  ),
                ],
              ),
            ),
    );
  }
}
