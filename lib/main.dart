import 'package:flutter/material.dart';
import 'package:neurozen_front/features/shell/main_shell_screen.dart';

void main() {
  runApp(const NeurozenApp());
}

class NeurozenApp extends StatelessWidget {
  const NeurozenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neurozen Mock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6FB98F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4FBF6),
      ),
      home: const MainShellScreen(),
    );
  }
}
