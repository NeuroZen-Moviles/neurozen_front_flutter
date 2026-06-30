import 'package:flutter/material.dart';
import 'package:neurozen_front/core/mocks/mock_data.dart';
import 'package:neurozen_front/core/models/availability_slot.dart';
import 'package:neurozen_front/features/home/home_screen.dart';
import 'package:neurozen_front/features/patients/patient_screen.dart';
import 'package:neurozen_front/features/profile/profile_screen.dart';
import 'package:neurozen_front/features/schedule/schedule_screen.dart';

class MainShell extends StatefulWidget {
  final VoidCallback onLogout;

  const MainShell({super.key, required this.onLogout});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final availability = List<AvailabilitySlot>.from(mockAvailability);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePsychologistScreen(
        psychologist: mockPsychologist,
        patients: mockPatients,
      ),
      PatientsScreen(patients: mockPatients),
      ScheduleScreen(
        availability: availability,
        onUpdate: () => setState(() {}),
      ),
      ProfileScreen(psychologist: mockPsychologist, onLogout: widget.onLogout),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Pacientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule_outlined),
            selectedIcon: Icon(Icons.schedule),
            label: 'Horario',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
