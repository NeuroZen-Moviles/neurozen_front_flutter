import 'package:neurozen_front/core/models/session.dart';

const mockSessions = <MeditationSession>[
  MeditationSession(
    id: 's1',
    title: 'Bosque Interior',
    description: 'Visualización guiada para relajar mente y cuerpo.',
    durationMinutes: 10,
    category: 'Meditación',
    level: 'Principiante',
    isFavorite: true,
  ),
  MeditationSession(
    id: 's2',
    title: 'Respiración 4-7-8',
    description: 'Técnica breve para bajar ansiedad rápidamente.',
    durationMinutes: 5,
    category: 'Respiración',
    level: 'Principiante',
    isFavorite: false,
  ),
  MeditationSession(
    id: 's3',
    title: 'Sueño Reparador',
    description: 'Rutina nocturna para descansar mejor.',
    durationMinutes: 15,
    category: 'Sueño',
    level: 'Intermedio',
    isFavorite: true,
  ),
  MeditationSession(
    id: 's4',
    title: 'Pausa Antiestrés',
    description: 'Micro-pausa para resetear en días pesados.',
    durationMinutes: 7,
    category: 'Estrés',
    level: 'Principiante',
    isFavorite: false,
  ),
  MeditationSession(
    id: 's5',
    title: 'Enfoque Profundo',
    description: 'Sesión para concentración y productividad.',
    durationMinutes: 12,
    category: 'Productividad',
    level: 'Intermedio',
    isFavorite: false,
  ),
];
