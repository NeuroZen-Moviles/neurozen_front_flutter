import 'package:flutter/material.dart';

class _QuickMomentsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moments = ['Respira 2 min', 'Pausa mental', 'Estiramiento'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: moments
          .map(
            (m) =>
                Chip(label: Text(m), avatar: const Icon(Icons.spa, size: 16)),
          )
          .toList(),
    );
  }
}
