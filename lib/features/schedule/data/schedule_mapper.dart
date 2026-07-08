import 'dart:convert';

class ScheduleMapper {
  static Map<String, dynamic> parse(String raw) {
    if (raw.trim().isEmpty) {
      return {
        'timezone': 'America/Lima',
        'weekly': <Map<String, dynamic>>[],
        'exceptions': <Map<String, dynamic>>[],
      };
    }
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return {
        'timezone': 'America/Lima',
        'weekly': <Map<String, dynamic>>[],
        'exceptions': <Map<String, dynamic>>[],
        'legacyText': raw,
      };
    }
  }

  static String stringify({
    required String timezone,
    required List<Map<String, dynamic>> weekly,
    required List<Map<String, dynamic>> exceptions,
  }) {
    return jsonEncode({
      'timezone': timezone,
      'weekly': weekly,
      'exceptions': exceptions,
    });
  }
}
