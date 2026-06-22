import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/session.dart';
import 'package:neurozen_front/features/sessions/widgets/session_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Session> recommended;
  final ValueChanged<Session> onSessionTap;

  const HomeScreen({
    super.key,
    required this.recommended,
    required this.onSessionTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Hola 👋',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('¿Cómo te sientes hoy?'),
          const SizedBox(height: 16),
          const Card(
            color: Color(0xFFE7F7EC),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Estrés: Bajo • Energía: Media • Sueño: 7h'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sesiones recomendadas',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...recommended.map(
            (s) => SessionCard(session: s, onTap: () => onSessionTap(s)),
          ),
        ],
      ),
    );
  }
}
