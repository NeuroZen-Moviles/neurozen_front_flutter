import 'package:flutter/material.dart';

class ProfileCompletionCard extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfileCompletionCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const progress = 0.5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Completa tu perfil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              'Completa tu información profesional para que los pacientes puedan encontrarte y reservar citas.',
            ),

            const SizedBox(height: 16),

            const LinearProgressIndicator(value: progress),

            const SizedBox(height: 8),

            const Text('2 de 4 pasos completados'),

            const SizedBox(height: 16),

            FilledButton(
              onPressed: onPressed,
              child: const Text('Completar perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
