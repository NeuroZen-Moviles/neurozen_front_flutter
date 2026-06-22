import 'package:flutter/material.dart';
import 'package:neurozen_front/core/mocks/mock_sessions.dart';
import 'package:neurozen_front/core/models/session.dart';
import '../home/home_screen.dart';
import '../sessions/sessions_screen.dart';
import '../sessions/session_detail_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  List<Session> sessions = List.of(mockSessions);

  void toggleFav(String id) {
    setState(() {
      final i = sessions.indexWhere((e) => e.id == id);
      sessions[i] = sessions[i].copyWith(isFavorite: !sessions[i].isFavorite);
    });
  }

  void openDetail(Session s) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SessionDetailScreen(
          session: s,
          onToggleFavorite: () => toggleFav(s.id),
        ),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        recommended: sessions.take(3).toList(),
        onSessionTap: openDetail,
      ),
      SessionsScreen(
        sessions: sessions,
        onToggleFavorite: toggleFav,
        onSessionTap: openDetail,
      ),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
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
}
