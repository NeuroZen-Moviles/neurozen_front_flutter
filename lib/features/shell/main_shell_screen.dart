import 'package:flutter/material.dart';
import 'package:neurozen_front/core/mocks/mock_sessions.dart';
import 'package:neurozen_front/core/models/session.dart';
import 'package:neurozen_front/features/home/home_screen.dart';
import 'package:neurozen_front/features/sessions/session_detail_screen.dart';
import 'package:neurozen_front/features/sessions/sessions_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;
  final List<MeditationSession> _sessions = mockSessions;

  List<MeditationSession> get _favoriteSessions =>
      _sessions.where((s) => s.isFavorite).toList();

  void _toggleFavorite(String id) {
    setState(() {
      final index = _sessions.indexWhere((s) => s.id == id);
      if (index != -1) {
        _sessions[index] = _sessions[index].copyWith(
          isFavorite: !_sessions[index].isFavorite,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        sessions: _sessions.take(4).toList(),
        onSessionTap: _openSessionDetail,
      ),
      SessionsScreen(
        sessions: _sessions,
        favoriteSessions: _favoriteSessions,
        onToggleFavorite: _toggleFavorite,
        onSessionTap: _openSessionDetail,
      ),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Sesiones',
          ),
        ],
      ),
    );
  }

  void _openSessionDetail(MeditationSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SessionDetailScreen(
          session: session,
          onToggleFavorite: () => _toggleFavorite(session.id),
        ),
      ),
    );
  }
}
