import 'package:flutter/material.dart';
import 'package:neurozen_front/core/models/psychologist.dart';
import 'package:neurozen_front/core/network/api_client.dart';
import 'package:neurozen_front/core/network/api_routes.dart';

class ProfessionalsRepository {
  final ApiClient apiClient;

  ProfessionalsRepository(this.apiClient);

  Future<List<Psychologist>> getAll() async {
    final res = await apiClient.dio.get(ApiRoutes.professionals);

    return (res.data as List)
        .map((e) => Psychologist.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Psychologist> getById(String id) async {
    final res = await apiClient.dio.get(ApiRoutes.professionalById(id));

    return Psychologist.fromJson(Map<String, dynamic>.from(res.data));
  }

  Future<Map<String, dynamic>> createProfessional({
    required String name,
    required String email,
    required String? specialty,
    required String availability, // string en BD
    required String experience,
    required int price,
    required int rating,
    required int reviews,
    required String bio,
    required String image,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'specialty': specialty,
      'availability': availability,
      'experience': experience,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'bio': bio,
      'image': image,
    };

    debugPrint(body.toString());

    final res = await apiClient.dio.post(ApiRoutes.professionals, data: body);

    return Map<String, dynamic>.from(res.data as Map);
  }
}
