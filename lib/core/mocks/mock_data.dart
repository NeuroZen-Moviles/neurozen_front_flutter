import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/availability_slot.dart';
import 'package:neurozen_front/core/models/patient.dart';
import 'package:neurozen_front/core/models/psychologist.dart';

final mockPsychologist = Psychologist(
  name: 'Dra. Andrea Morales',
  specialty: 'Psicología Clínica',
  email: 'andrea.morales@neurozen.app',
);

final mockPatients = <Patient>[
  Patient(
    name: 'María R.',
    reason: 'Ansiedad',
    nextAppointment: DateTime.now().add(const Duration(hours: 2)),
    status: 'Confirmada',
  ),
  Patient(
    name: 'Carlos P.',
    reason: 'Manejo de estrés',
    nextAppointment: DateTime.now().add(const Duration(days: 1, hours: 1)),
    status: 'Pendiente',
  ),
  Patient(
    name: 'Lucía G.',
    reason: 'Trastornos del sueño',
    nextAppointment: DateTime.now().add(const Duration(days: 2)),
    status: 'Confirmada',
  ),
];

final mockAvailability = <AvailabilitySlot>[
  AvailabilitySlot(
    day: 'Lunes',
    start: const TimeOfDay(hour: 9, minute: 0),
    end: const TimeOfDay(hour: 13, minute: 0),
    active: true,
  ),
  AvailabilitySlot(
    day: 'Miércoles',
    start: const TimeOfDay(hour: 14, minute: 0),
    end: const TimeOfDay(hour: 18, minute: 0),
    active: true,
  ),
  AvailabilitySlot(
    day: 'Viernes',
    start: const TimeOfDay(hour: 10, minute: 0),
    end: const TimeOfDay(hour: 15, minute: 0),
    active: false,
  ),
];
