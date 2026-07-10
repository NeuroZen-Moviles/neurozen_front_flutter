class Psychologist {
  final String id;
  final String name;
  final String specialty;
  final String email;
  final String availability;
  final int experience;
  final int price;
  final double? rating;
  final int? reviews;
  final String? bio;
  final String? image;

  const Psychologist({
    required this.id,
    required this.name,
    required this.specialty,
    required this.email,
    required this.availability,
    required this.experience,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.bio,
    required this.image,
  });

  factory Psychologist.fromJson(Map<String, dynamic> json) {
    return Psychologist(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      specialty: json['specialty'] ?? '',

      availability: json['availability'] ?? '',

      experience: int.tryParse(json['experience'].toString()) ?? 0,

      price: int.tryParse(json['price'].toString()) ?? 0,

      rating: double.tryParse(json['rating'].toString()) ?? 0,

      reviews: int.tryParse(json['reviews'].toString()) ?? 0,

      bio: json['bio'],
      image: json['image'],
    );
  }
}
