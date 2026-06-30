import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/patient.dart';
import 'package:neurozen_front/utils/date_format.dart';

class PatientsScreen extends StatelessWidget {
  final List<Patient> patients;

  const PatientsScreen({super.key, required this.patients});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (_, i) {
          final p = patients[i];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(p.name),
              subtitle: Text(
                '${p.reason}\nPróxima cita: ${fmtDateTime(p.nextAppointment)}',
              ),
              isThreeLine: true,
              trailing: Chip(label: Text(p.status)),
            ),
          );
        },
      ),
    );
  }
}
