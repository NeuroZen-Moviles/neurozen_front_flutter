import 'package:flutter/material.dart';

final neurozenTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6FB98F),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF4FBF6),
  cardTheme: const CardThemeData(
    elevation: 0.5,
    margin: EdgeInsets.only(bottom: 12),
  ),
);
