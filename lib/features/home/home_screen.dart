import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/patient.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/utils/date_format.dart';

class HomePsychologistScreen extends StatelessWidget {
  final Psychologist psychologist;
  final List<Patient> patients;

  const HomePsychologistScreen({
    super.key,
    required this.psychologist,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    final todayCount = patients
        .where(
          (p) =>
              p.nextAppointment.day == DateTime.now().day &&
              p.nextAppointment.month == DateTime.now().month &&
              p.nextAppointment.year == DateTime.now().year,
        )
        .length;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Hola, ${psychologist.name}',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(psychologist.specialty),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _MetricCard(title: 'Citas hoy', value: '$todayCount'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  title: 'Pacientes activos',
                  value: '${patients.length}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'Próximas citas',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          ...patients
              .take(3)
              .map(
                (p) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(p.name),
                    subtitle: Text(
                      '${p.reason} • ${fmtDateTime(p.nextAppointment)}',
                    ),
                    trailing: Text(p.status),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const _MetricCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE6F6EA),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
