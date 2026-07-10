import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';
import 'package:neurozen_front/features/schedule/schedule_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final Psychologist psychologist;
  final SessionStorage storage;

  const EditProfileScreen({
    super.key,
    required this.psychologist,
    required this.storage,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController bioCtrl;
  late final TextEditingController experienceCtrl;
  late final TextEditingController priceCtrl;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    bioCtrl = TextEditingController(text: widget.psychologist.bio ?? '');

    experienceCtrl = TextEditingController(
      text: widget.psychologist.experience.toString(),
    );

    priceCtrl = TextEditingController(
      text: widget.psychologist.price.toString(),
    );
  }

  Future<void> _saveChanges() async {
    setState(() => loading = true);

    try {
      await widget.storage.saveProfileCache({
        'bio': bioCtrl.text.trim(),
        'experience': int.tryParse(experienceCtrl.text) ?? 0,
        'price': int.tryParse(priceCtrl.text) ?? 0,
      });

      await widget.storage.setProfileCompleted(true);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado correctamente')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al guardar: $e')));
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    bioCtrl.dispose();
    experienceCtrl.dispose();
    priceCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: bioCtrl,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Biografía',
                hintText: 'Cuéntale a los pacientes sobre ti',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: experienceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Años de experiencia',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio por sesión',
                prefixText: 'S/. ',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScheduleScreen()),
                );
              },
              icon: const Icon(Icons.schedule),
              label: const Text('Gestionar horario'),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: loading ? null : _saveChanges,
                child: loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Guardar cambios'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
