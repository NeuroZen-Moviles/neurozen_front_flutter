import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';
import 'package:neurozen_front/features/schedule/schedule_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  final Psychologist psychologist;
  final SessionStorage storage;

  const CompleteProfileScreen({
    super.key,
    required this.psychologist,
    required this.storage,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  late final TextEditingController bioCtrl;
  late final TextEditingController experienceCtrl;
  late final TextEditingController priceCtrl;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Completar perfil')),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: bioCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Biografía',
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
            label: const Text('Configurar horario'),
          ),

          const SizedBox(height: 20),

          FilledButton(
            onPressed: () async {
              await widget.storage.saveProfileCache({
                'bio': bioCtrl.text,
                'experience': int.tryParse(experienceCtrl.text) ?? 0,
                'price': int.tryParse(priceCtrl.text) ?? 0,
              });

              await widget.storage.setProfileCompleted(true);

              if (!context.mounted) return;

              Navigator.pop(context, true);
            },
            child: const Text('Guardar cambios'),
          ),
        ],
      ),
    );
  }
}
