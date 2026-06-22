import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/session.dart';

class SessionDetailScreen extends StatelessWidget {
  final Session session;
  final VoidCallback onToggleFavorite;

  const SessionDetailScreen({
    super.key,
    required this.session,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('${session.duration} min • ${session.level}'),
            const SizedBox(height: 16),
            Text(session.description),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onToggleFavorite,
              icon: Icon(
                session.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              label: Text(
                session.isFavorite ? 'Quitar favorito' : 'Agregar favorito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
