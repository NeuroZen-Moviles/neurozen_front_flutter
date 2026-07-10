import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';
import 'package:neurozen_front/features/auth/data/auth_repo.dart';
import 'package:neurozen_front/features/professionals/data/professionals_repo.dart';

class RegisterScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final ProfessionalsRepository professionalsRepo;
  final SessionStorage storage;

  const RegisterScreen({
    super.key,
    required this.authRepository,
    required this.professionalsRepo,
    required this.storage,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  bool loading = false;
  bool obscure1 = true;
  String? selectedSpecialty;

  final List<String> specialties = [
    'Psicología Clínica',
    'Psicología Infantil',
    'Psicología Educativa',
    'Psicología Organizacional',
    'Neuropsicología',
    'Psicología Familiar',
    'Psicología de Pareja',
    'Psicología del Adulto Mayor',
  ];

  Future<void> _submit() async {
    final username = usernameCtrl.text.trim();
    final password = passwordCtrl.text;
    final email = emailCtrl.text;

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      _show('Completa todos los campos');
      return;
    }
    if (password.length < 6) {
      _show('La contraseña debe tener al menos 6 caracteres');
      return;
    }
    if (!email.contains("@")) {
      _show('Email inválido');
      return;
    }

    if (selectedSpecialty == null) {
      _show('Selecciona una especialidad');
      return;
    }
    setState(() => loading = true);
    try {
      debugPrint('Creando usuario...');

      await widget.authRepository.signUp(
        username: username,
        password: password,
        email: email,
      );

      await widget.authRepository.signIn(
        username: username,
        password: password,
      );

      debugPrint("SignIn OK");

      await widget.storage.saveUsername(username);

      debugPrint('Usuario creado');

      await widget.professionalsRepo.createProfessional(
        name: username,
        email: email,
        specialty: selectedSpecialty,
        availability: "0",
        experience: "0",
        price: 0,
        rating: 0,
        reviews: 0,
        bio: "Insertar bio",
        image: "Insertar img",
      );

      debugPrint('Profesional creado');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada correctamente')),
      );

      Navigator.pop(context);
    } on DioException catch (e, stackTrace) {
      debugPrint("STATUS: ${e.response?.statusCode}");
      debugPrint("BODY: ${e.response?.data}");
      debugPrintStack(stackTrace: stackTrace);

      _show(e.response?.data.toString() ?? e.toString());
    } catch (e, stackTrace) {
      debugPrint("ERROR: $e");
      debugPrintStack(stackTrace: stackTrace);

      _show(e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  String _mapError(Object e) {
    final text = e.toString().toLowerCase();
    if (text.contains('409')) return 'El usuario ya existe';
    if (text.contains('400')) return 'Datos inválidos';
    if (text.contains('socket') || text.contains('timeout')) {
      return 'Sin conexión con el servidor';
    }
    return 'No se pudo crear la cuenta';
  }

  void _show(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordCtrl,
              obscureText: obscure1,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => obscure1 = !obscure1),
                  icon: Icon(
                    obscure1 ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedSpecialty,
              decoration: const InputDecoration(
                labelText: 'Especialidad',
                border: OutlineInputBorder(),
              ),
              items: specialties.map((specialty) {
                return DropdownMenuItem<String>(
                  value: specialty,
                  child: Text(specialty),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSpecialty = value;
                });
              },
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
                    : const Text('Registrarme'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
