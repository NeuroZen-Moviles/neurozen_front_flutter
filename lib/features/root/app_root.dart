import 'package:flutter/material.dart';
import 'package:neurozen_front/features/auth/login_screen.dart';
import 'package:neurozen_front/features/shell/main_shell.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool isLoggedIn = false;

  void _onLoginSuccess() => setState(() => isLoggedIn = true);
  void _onLogout() => setState(() => isLoggedIn = false);

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? MainShell(onLogout: _onLogout)
        : LoginScreen(onLoginSuccess: _onLoginSuccess);
  }
}
