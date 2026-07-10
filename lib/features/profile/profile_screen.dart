import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';
import 'package:neurozen_front/features/profile/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Psychologist psychologist;
  final VoidCallback onLogout;
  final VoidCallback onProfileUpdated;

  const ProfileScreen({
    super.key,
    required this.psychologist,
    required this.onLogout,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final incomplete =
        psychologist.bio == null ||
        psychologist.bio!.isEmpty ||
        psychologist.experience == 0 ||
        psychologist.price == 0;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),

          const SizedBox(height: 12),

          Center(
            child: Text(
              psychologist.name,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          Center(child: Text(psychologist.specialty)),
          Center(child: Text(psychologist.email)),

          const SizedBox(height: 20),

          if (incomplete)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        SizedBox(width: 8),
                        Text(
                          'Perfil incompleto',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Completa tu información profesional para mejorar tu visibilidad ante pacientes.',
                    ),

                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: () {
                        // ir a horario o pantalla informativa
                      },
                      child: const Text('Completar perfil'),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 12),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Biografía'),
                  subtitle: Text(
                    psychologist.bio?.isNotEmpty == true
                        ? psychologist.bio!
                        : 'Sin información',
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text('Experiencia'),
                  subtitle: Text('${psychologist.experience} años'),
                ),

                ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Precio por sesión'),
                  subtitle: Text('S/. ${psychologist.price}'),
                ),

                ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Valoración'),
                  subtitle: Text(
                    '${psychologist.rating} (${psychologist.reviews} reseñas)',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfileScreen(
                    psychologist: psychologist,
                    storage: SessionStorage(),
                  ),
                ),
              );

              if (updated == true) {
                onProfileUpdated();
              }
            },
            icon: const Icon(Icons.edit),
            label: const Text('Editar perfil'),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
