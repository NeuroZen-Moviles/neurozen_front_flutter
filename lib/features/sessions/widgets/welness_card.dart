import 'package:flutter/material.dart';

class _WellnessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE7F7EC),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tu bienestar hoy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Estrés: Bajo • Energía: Media • Sueño: 7h'),
          ],
        ),
      ),
    );
  }
}
