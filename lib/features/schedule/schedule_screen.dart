import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'models/availability_models.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<WeeklyAvailability> weekly = [
    WeeklyAvailability(
      dow: 1,
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 13, minute: 0),
      active: true,
    ),
    WeeklyAvailability(
      dow: 2,
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 13, minute: 0),
      active: false,
    ),
    WeeklyAvailability(
      dow: 3,
      start: const TimeOfDay(hour: 14, minute: 0),
      end: const TimeOfDay(hour: 18, minute: 0),
      active: true,
    ),
    WeeklyAvailability(
      dow: 4,
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 13, minute: 0),
      active: false,
    ),
    WeeklyAvailability(
      dow: 5,
      start: const TimeOfDay(hour: 10, minute: 0),
      end: const TimeOfDay(hour: 15, minute: 0),
      active: true,
    ),
    WeeklyAvailability(
      dow: 6,
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 12, minute: 0),
      active: false,
    ),
    WeeklyAvailability(
      dow: 7,
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 12, minute: 0),
      active: false,
    ),
  ];

  final List<AvailabilityException> exceptions = [];
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horario de atención'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Semanal'),
            Tab(text: 'Excepciones'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildWeeklyTab(), _buildExceptionsTab()],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: _saveSchedule,
            icon: const Icon(Icons.save),
            label: const Text('Guardar cambios'),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: weekly.length,
      itemBuilder: (_, i) {
        final slot = weekly[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      dowLabelEs(slot.dow),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Switch(
                      value: slot.active,
                      onChanged: (v) => setState(() => slot.active = v),
                    ),
                  ],
                ),
                if (slot.active) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: slot.start,
                            );
                            if (picked != null)
                              setState(() => slot.start = picked);
                          },
                          child: Text('Inicio: ${slot.start.format(context)}'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: slot.end,
                            );
                            if (picked != null)
                              setState(() => slot.end = picked);
                          },
                          child: Text('Fin: ${slot.end.format(context)}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExceptionsTab() {
    final selectedDate = _dateOnly(selectedDay ?? DateTime.now());
    final exception = _findException(selectedDate);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2035, 12, 31),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;
            });
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Excepción para ${_fmtDate(selectedDate)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('No disponible todo el día'),
                  value: exception?.off ?? false,
                  onChanged: (v) => setState(() {
                    final e = _upsertException(selectedDate);
                    e.off = v;
                    if (v) {
                      e.start = null;
                      e.end = null;
                    }
                  }),
                ),
                if ((exception?.off ?? false) == false) ...[
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final e = _upsertException(selectedDate);
                            final picked = await showTimePicker(
                              context: context,
                              initialTime:
                                  e.start ??
                                  const TimeOfDay(hour: 9, minute: 0),
                            );
                            if (picked != null)
                              setState(() => e.start = picked);
                          },
                          child: Text(
                            'Inicio: ${exception?.start?.format(context) ?? "--:--"}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final e = _upsertException(selectedDate);
                            final picked = await showTimePicker(
                              context: context,
                              initialTime:
                                  e.end ?? const TimeOfDay(hour: 13, minute: 0),
                            );
                            if (picked != null) setState(() => e.end = picked);
                          },
                          child: Text(
                            'Fin: ${exception?.end?.format(context) ?? "--:--"}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => setState(() {
                    exceptions.removeWhere(
                      (e) => _sameDate(e.date, selectedDate),
                    );
                  }),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Eliminar excepción'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _saveSchedule() {
    // Aquí luego mapeas a JSON o string para tu backend.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Cambios guardados (mock)')));
  }

  AvailabilityException _upsertException(DateTime date) {
    final existing = _findException(date);
    if (existing != null) return existing;
    final created = AvailabilityException(date: date, off: false);
    exceptions.add(created);
    return created;
  }

  AvailabilityException? _findException(DateTime date) {
    try {
      return exceptions.firstWhere((e) => _sameDate(e.date, date));
    } catch (_) {
      return null;
    }
  }

  bool _sameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
