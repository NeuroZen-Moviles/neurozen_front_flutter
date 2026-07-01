import 'package:flutter/material.dart';

class WeeklyAvailability {
  final int dow; // 1=Lun ... 7=Dom
  TimeOfDay start;
  TimeOfDay end;
  bool active;

  WeeklyAvailability({
    required this.dow,
    required this.start,
    required this.end,
    this.active = true,
  });
}

class AvailabilityException {
  final DateTime date; // solo fecha
  bool off; // true = no disponible
  TimeOfDay? start;
  TimeOfDay? end;

  AvailabilityException({
    required this.date,
    this.off = true,
    this.start,
    this.end,
  });
}

String dowLabelEs(int dow) {
  const map = {
    1: 'Lunes',
    2: 'Martes',
    3: 'Miércoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo',
  };
  return map[dow] ?? 'Día';
}
