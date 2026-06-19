import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/session.dart';

class SessionCard extends StatelessWidget {
  final MeditationSession session;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  const SessionCard({
    super.key,
    required this.session,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        title: Text(session.title),
        subtitle: Text('${session.durationMinutes} min • ${session.category}'),
        trailing: IconButton(
          onPressed: onFavoriteTap,
          icon: Icon(
            session.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: session.isFavorite ? Colors.red : null,
          ),
        ),
      ),
    );
  }
}


