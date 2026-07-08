import 'package:flutter/material.dart';
import 'package:neurozen_front/features/auth/data/auth_repo.dart';
import 'package:neurozen_front/features/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final VoidCallback onLoginSuccess;

  const LoginScreen({
    super.key,
    required this.authRepository,
    required this.onLoginSuccess,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool loading = false;
  bool obscure = true;

  Future<void> _submit() async {
    if (usernameCtrl.text.trim().isEmpty || passwordCtrl.text.isEmpty) {
      _show('Completa usuario y contraseña');
      return;
    }

    setState(() => loading = true);
    try {
      await widget.authRepository.signIn(
        username: usernameCtrl.text.trim(),
        password: passwordCtrl.text,
      );
      widget.onLoginSuccess();
    } catch (e) {
      final msg = e.toString();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error login'),
          content: SingleChildScrollView(child: Text(msg)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  String _mapError(Object e) {
    final text = e.toString().toLowerCase();
    if (text.contains('401')) return 'Credenciales inválidas';
    if (text.contains('400')) return 'Solicitud inválida';
    if (text.contains('socket') || text.contains('timeout'))
      return 'Sin conexión con el servidor';
    return 'No se pudo iniciar sesión';
  }

  void _show(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 40),
            Icon(
              Icons.psychology,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'Acceso Psicólogos',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 28),
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordCtrl,
              obscureText: obscure,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => obscure = !obscure),
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: loading ? null : _submit,
                child: loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Iniciar sesión'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: loading
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(
                            authRepository: widget.authRepository,
                          ),
                        ),
                      );
                    },
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
