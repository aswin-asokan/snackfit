// lib/features/suggestion/screens/api_key_section.dart
import 'package:flutter/material.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';
import 'package:frontend/features/suggestion/services/database_helper.dart';

class ApiKeySection extends StatefulWidget {
  const ApiKeySection({super.key});

  @override
  State<ApiKeySection> createState() => _ApiKeySectionState();
}

class _ApiKeySectionState extends State<ApiKeySection> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    final apiKey = await SuggestionsDB.instance.getApiKey();
    if (apiKey != null) {
      controller.text = apiKey;
    }
  }

  Future<void> _saveApiKey() async {
    if (controller.text.isNotEmpty) {
      await SuggestionsDB.instance.insertApiKey(controller.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('API Key saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('API Key cannot be empty.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text("API Key", style: context.textTheme.titleSmall),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
              onPressed: _saveApiKey, // Call the save method
              icon: const Icon(Icons.save_outlined),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
