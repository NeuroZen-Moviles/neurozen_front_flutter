import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/availability_slot.dart';

class ScheduleScreen extends StatelessWidget {
  final List<AvailabilitySlot> availability;
  final VoidCallback onUpdate;

  const ScheduleScreen({
    super.key,
    required this.availability,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Horario de atención',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...availability.map(
            (slot) => Card(
              child: SwitchListTile(
                title: Text(slot.day),
                subtitle: Text(
                  '${slot.start.format(context)} - ${slot.end.format(context)}',
                ),
                value: slot.active,
                onChanged: (v) {
                  slot.active = v;
                  onUpdate();
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Editar bloques horarios (siguiente paso)'),
                ),
              );
            },
            icon: const Icon(Icons.edit_calendar),
            label: const Text('Editar bloques horarios'),
          ),
        ],
      ),
    );
  }
}
