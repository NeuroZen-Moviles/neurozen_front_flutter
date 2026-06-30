import 'package:flutter/material.dart';
import 'package:neurozen_front/features/root/app_root.dart';

class NeurozenApp extends StatelessWidget {
  const NeurozenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neurozen',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5FAF7A)),
        scaffoldBackgroundColor: const Color(0xFFF5FBF6),
      ),
      home: const AppRoot(),
    );
  }
}
