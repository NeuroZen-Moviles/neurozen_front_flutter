class Patient {
  final String name;
  final String reason;
  final DateTime nextAppointment;
  final String status;

  const Patient({
    required this.name,
    required this.reason,
    required this.nextAppointment,
    required this.status,
  });
}
