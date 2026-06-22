class Session {
  final String id;
  final String title;
  final String description;
  final int duration;
  final String category;
  final String level;
  final bool isFavorite;

  const Session({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.category,
    required this.level,
    required this.isFavorite,
  });

  Session copyWith({bool? isFavorite}) => Session(
        id: id,
        title: title,
        description: description,
        duration: duration,
        category: category,
        level: level,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}