class MeditationSession {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final String category;
  final String level;
  final bool isFavorite;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.category,
    required this.level,
    required this.isFavorite,
  });

  MeditationSession copyWith({
    String? id,
    String? title,
    String? description,
    int? durationMinutes,
    String? category,
    String? level,
    bool? isFavorite,
  }) {
    return MeditationSession(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      category: category ?? this.category,
      level: level ?? this.level,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
