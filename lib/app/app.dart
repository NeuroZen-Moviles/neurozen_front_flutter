import 'package:flutter/material.dart';
import 'package:neurozen_front/app/theme.dart';
import 'package:neurozen_front/features/shell/main_shell.dart';

class NeurozenApp extends StatelessWidget {
  const NeurozenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neurozen',
      theme: neurozenTheme,
      home: const MainShell(),
    );
  }
}