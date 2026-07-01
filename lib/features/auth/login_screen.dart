import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.psychology,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'NeuroZen Psicólogos',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Correo profesional',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passCtrl,
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => obscure = !obscure),
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // Mock login simple
                    if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
                      widget.onLoginSuccess();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa correo y contraseña'),
                        ),
                      );
                    }
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
