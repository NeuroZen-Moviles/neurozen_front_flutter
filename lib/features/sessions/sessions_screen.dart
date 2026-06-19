import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/session.dart';
import 'package:neurozen_front/features/sessions/widgets/session_card.dart';

class SessionsScreen extends StatefulWidget {
  final List<MeditationSession> sessions;
  final List<MeditationSession> favoriteSessions;
  final ValueChanged<String> onToggleFavorite;
  final ValueChanged<MeditationSession> onSessionTap;

  const SessionsScreen({
    super.key,
    required this.sessions,
    required this.favoriteSessions,
    required this.onToggleFavorite,
    required this.onSessionTap,
  });

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  bool onlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final visible = onlyFavorites ? widget.favoriteSessions : widget.sessions;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(
                  onlyFavorites ? 'Mis Favoritos' : 'Sesiones para ti',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                FilterChip(
                  label: const Text('Solo favoritos'),
                  selected: onlyFavorites,
                  onSelected: (value) => setState(() => onlyFavorites = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(child: Text('No tienes sesiones favoritas aún.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: visible.length,
                    itemBuilder: (_, i) {
                      final s = visible[i];
                      return SessionCard(
                        session: s,
                        onTap: () => widget.onSessionTap(s),
                        onFavoriteTap: () => widget.onToggleFavorite(s.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
