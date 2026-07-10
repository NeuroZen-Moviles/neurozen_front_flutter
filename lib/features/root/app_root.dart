import 'package:flutter/material.dart';
import 'package:neurozen_front/core/network/api_client.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';
import 'package:neurozen_front/features/auth/data/auth_repo.dart';
import 'package:neurozen_front/features/auth/login_screen.dart';
import 'package:neurozen_front/features/professionals/data/professionals_repo.dart';
import 'package:neurozen_front/features/shell/main_shell.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final SessionStorage storage;
  late final ApiClient apiClient;
  late final AuthRepository authRepository;
  late final ProfessionalsRepository professionalsRepository;

  bool loading = true;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    storage = SessionStorage();
    apiClient = ApiClient(storage);
    authRepository = AuthRepository(apiClient: apiClient, storage: storage);
    professionalsRepository = ProfessionalsRepository(apiClient);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final ok = await storage.isLoggedIn();
    final token = await storage.readToken();
    setState(() {
      loggedIn = ok && token != null && token.isNotEmpty;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!loggedIn) {
      return LoginScreen(
        authRepository: authRepository,
        professionalsRepository: professionalsRepository,
        onLoginSuccess: () => setState(() => loggedIn = true),
      );
    }

    return MainShell(
      professionalsRepository: professionalsRepository,

      onLogout: () async {
        await authRepository.logout();

        if (!mounted) return;

        setState(() {
          loggedIn = false;
        });
      },
    );
  }
}
