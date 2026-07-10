import 'package:flutter/material.dart';
import 'package:neurozen_front/core/mocks/mock_data.dart';
import 'package:neurozen_front/core/models/availability_slot.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/core/storage/session_storage.dart';
import 'package:neurozen_front/features/home/home_screen.dart';
import 'package:neurozen_front/features/patients/patient_screen.dart';
import 'package:neurozen_front/features/professionals/data/professionals_repo.dart';
import 'package:neurozen_front/features/profile/profile_screen.dart';
import 'package:neurozen_front/features/schedule/schedule_screen.dart';

class MainShell extends StatefulWidget {
  final VoidCallback onLogout;
  final ProfessionalsRepository professionalsRepository;
  final SessionStorage storage;

  const MainShell({
    super.key,
    required this.professionalsRepository,
    required this.storage,
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

  @override
  void initState() {
    super.initState();
    _loadPsychologist();
  }

  Future<void> _loadPsychologist() async {
    try {
      final username = await widget.storage.readUsername();

      if (username == null) {
        throw Exception("No hay usuario en la sesión");
      }

      final professionals = await widget.professionalsRepository.getAll();

      final result = professionals.firstWhere((p) => p.name == username);

      final cache = await widget.storage.readProfileCache();

      Psychologist psychologistData = result;

      if (cache != null) {
        psychologistData = Psychologist(
          id: result.id,
          name: result.name,
          email: result.email,
          specialty: result.specialty,
          availability: result.availability,
          experience: cache['experience'] ?? result.experience,
          price: cache['price'] ?? result.price,
          rating: result.rating,
          reviews: result.reviews,
          bio: cache['bio'] ?? result.bio,
          image: result.image,
        );
      }

      if (!mounted) return;

      setState(() {
        psychologist = psychologistData;
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

  Future<void> refreshPsychologist() async {
    await _loadPsychologist();
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
        storage: SessionStorage(),
        onProfileUpdated: refreshPsychologist,
      ),
      PatientsScreen(patients: mockPatients),
      ScheduleScreen(),
      ProfileScreen(
        psychologist: psychologist!,
        onLogout: widget.onLogout,
        onProfileUpdated: _loadPsychologist,
      ),
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
