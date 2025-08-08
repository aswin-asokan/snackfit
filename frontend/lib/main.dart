import 'package:flutter/material.dart';
import 'package:frontend/core/theme/light_theme.dart';
import 'package:frontend/features/home/presentation/screens/home.dart';
import 'package:frontend/features/settings/presentation/screens/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackFit',
      debugShowCheckedModeBanner: false,
      theme: lightmode,
      home: const Home(),
      routes: {
        'home': (context) => const Home(),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
