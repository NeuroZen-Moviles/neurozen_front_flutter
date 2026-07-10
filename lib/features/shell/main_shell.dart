import 'package:flutter/material.dart';
import 'package:neurozen_front/core/mocks/mock_data.dart';
import 'package:neurozen_front/core/models/availability_slot.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/features/home/home_screen.dart';
import 'package:neurozen_front/features/patients/patient_screen.dart';
import 'package:neurozen_front/features/professionals/data/professionals_repo.dart';
import 'package:neurozen_front/features/profile/profile_screen.dart';
import 'package:neurozen_front/features/schedule/schedule_screen.dart';

class MainShell extends StatefulWidget {
  final VoidCallback onLogout;
  final ProfessionalsRepository professionalsRepository;

  const MainShell({
    super.key,
    required this.professionalsRepository,
    required this.onLogout,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  Psychologist? psychologist;
  bool loading = true;
  final availability = List<AvailabilitySlot>.from(mockAvailability);
  final psychologistId = 'b17ffc67-078d-449d-b9cf-dd5750bde271';

  @override
  void initState() {
    super.initState();
    _loadPsychologist();
  }

  Future<void> _loadPsychologist() async {
    try {
      final result = await widget.professionalsRepository.getById(
        psychologistId,
      );

      if (!mounted) return;

      setState(() {
        psychologist = result;
        loading = false;
      });
    } catch (e, stackTrace) {
      debugPrint('❌ LOAD PSYCHO ERROR: $e');
      debugPrint('$stackTrace');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading || psychologist == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final pages = [
      HomePsychologistScreen(
        psychologist: psychologist!,
        patients: mockPatients,
      ),
      PatientsScreen(patients: mockPatients),
      ScheduleScreen(),
      ProfileScreen(psychologist: psychologist!, onLogout: widget.onLogout),
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
