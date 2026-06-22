import 'package:neurozen_front/core/models/session.dart';

const mockSessions = <Session>[
  Session(
    id: '1',
    title: 'Bosque Interior',
    description: 'Relajación guiada',
    duration: 10,
    category: 'Meditación',
    level: 'Principiante',
    isFavorite: true,
  ),
  Session(
    id: '2',
    title: 'Respiración 4-7-8',
    description: 'Baja ansiedad rápido',
    duration: 5,
    category: 'Respiración',
    level: 'Principiante',
    isFavorite: false,
  ),
  Session(
    id: '3',
    title: 'Sueño Reparador',
    description: 'Mejora descanso',
    duration: 15,
    category: 'Sueño',
    level: 'Intermedio',
    isFavorite: true,
  ),
  Session(
    id: '4',
    title: 'Pausa Antiestrés',
    description: 'Reset mental',
    duration: 7,
    category: 'Estrés',
    level: 'Principiante',
    isFavorite: false,
  ),
];
