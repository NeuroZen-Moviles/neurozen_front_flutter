import 'package:flutter/material.dart';

class AvailabilitySlot {
  final String day;
  final TimeOfDay start;
  final TimeOfDay end;
  bool active;

  AvailabilitySlot({
    required this.day,
    required this.start,
    required this.end,
    this.active = true,
  });
}
