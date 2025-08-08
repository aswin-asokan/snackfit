import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/widgets/capture_section.dart';
import 'package:frontend/features/suggestion/presentation/screens/suggestions.dart';
import 'package:frontend/features/suggestion/services/database_helper.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';
import 'package:frontend/features/home/presentation/widgets/suggestion_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _capturedImage;
  List<Map<String, dynamic>> _recentServings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentServings();
  }

  Future<void> _loadRecentServings() async {
    final data = await SuggestionsDB.instance.fetchSuggestions();
    setState(() {
      _recentServings = data;
      _loading = false;
    });
  }

  void _handleImageCaptured(File image) async {
    setState(() {
      _capturedImage = image;
    });
    if (_capturedImage != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Suggestions(capturedImage: _capturedImage!),
        ),
      );
      _loadRecentServings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Home", style: context.textTheme.displayLarge),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings_outlined),
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
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _recentServings.isEmpty
                  ? const Center(child: Text("No servings yet."))
                  : RefreshIndicator(
                      onRefresh: _loadRecentServings,
                      child: ListView.separated(
                        itemCount: _recentServings.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = _recentServings[index];

                          return SuggestionCard(
                            title: item['title'],
                            suggestion: item['suggestion'],
                            date: item['date'],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
