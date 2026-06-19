import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/session.dart';
import 'package:neurozen_front/features/sessions/widgets/session_card.dart';

class HomeScreen extends StatelessWidget {
  final List<MeditationSession> sessions;
  final ValueChanged<MeditationSession> onSessionTap;

  const HomeScreen({
    super.key,
    required this.sessions,
    required this.onSessionTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Hola, Trevor 👋',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            '¿Cómo te sientes hoy?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          _WellnessCard(),
          const SizedBox(height: 16),
          _QuickMomentsRow(),
          const SizedBox(height: 20),
          Text(
            'Sesiones recomendadas',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...sessions.map(
            (s) => SessionCard(
              session: s,
              onTap: () => onSessionTap(s),
              onFavoriteTap: null,
            ),
          ),
        ],
      ),
    );
  }
}
